defmodule Cucurbit.Kino.Scene do
  @enforce_keys [:scene_fn, :fields]
  defstruct @enforce_keys

  @open_scad_path "/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD"
  @output_path "/Users/quinn/dev/cucurbit/out/output.scad"
  @image_path "/Users/quinn/dev/cucurbit/out/output.png"

  def new(fields, scene_fn) when is_list(fields) and is_function(scene_fn, 2) do
    %__MODULE__{
      scene_fn: scene_fn,
      fields: fields
    }
  end

  def render(%__MODULE__{} = scene) do
    sources = [
      Kino.Control.keyboard([:keydown]) |> Kino.render()
    ]

    frame = Kino.Frame.new() |> Kino.render()

    sources =
      if length(scene.fields) == 0 do
        sources
      else
        sources ++
          [
            Kino.Control.form(
              scene.fields,
              submit: "Render",
              report_changes: true
            )
            |> Kino.render()
          ]
      end

    if length(scene.fields) == 0 do
      image = do_render(scene.scene_fn, {50, 0, 25}, %{}, true)

      Kino.Frame.render(frame, image)
    end

    Kino.listen(Kino.Control.stream(sources), {{50, 0, 25}, %{}}, fn
      %{type: :keydown, key: key}, {{x, y, z}, data} ->
        {x, y, z} =
          case key do
            "ArrowLeft" -> {x, y, z - 15}
            "ArrowRight" -> {x, y, z + 15}
            "ArrowUp" -> {x - 15, y, z}
            "ArrowDown" -> {x + 15, y, z}
            _ -> {x, y, z}
          end

        try do
          image = do_render(scene.scene_fn, {x, y, z}, data, false)

          Kino.Frame.render(frame, image)
        rescue
          _ -> :ok
        end

        {:cont, {{x, y, z}, data}}

      %{type: :change} = event, {{x, y, z}, _} ->
        image = do_render(scene.scene_fn, {x, y, z}, event.data, true)

        Kino.Frame.render(frame, image)

        {:cont, {{x, y, z}, event.data}}

      %{type: :submit} = event, {{x, y, z}, _} ->
        image = do_render(scene.scene_fn, {x, y, z}, event.data, true)

        Kino.Frame.render(frame, image)

        {:cont, {{x, y, z}, event.data}}
    end)

    :ok
  end

  defp do_render(scene_fn, {x, y, z}, params, recompute) do
    if recompute do
      scenegraph = scene_fn.(Cucurbit.Scene.new(), params)

      Cucurbit.write(scenegraph, @output_path)
    end

    System.cmd(
      @open_scad_path,
      [
        "-o",
        @image_path,
        "--camera=0,0,0,#{x},#{y},#{z},0",
        "--viewall",
        "--autocenter",
        "--view=axes",
        @output_path
      ]
    )

    content = File.read!(@image_path)

    Kino.Image.new(content, "image/png")
  end
end
