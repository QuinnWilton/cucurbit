defmodule Cucurbit.OpenSCAD.Body.Cube do
  @enforce_keys [:size]
  defstruct @enforce_keys ++ [:center]

  def new(size, opts \\ []) do
    %__MODULE__{
      size: size,
      center: Keyword.get(opts, :center)
    }
  end

  defimpl Cucurbit.OpenSCAD.IntoOpenSCAD do
    def into_open_scad(data, opts) do
      fn_call = %Cucurbit.OpenSCAD.FnCall{
        name: "cube",
        args: [],
        keyword_args: [
          {"size", data.size},
          {"center", data.center}
        ]
      }

      @protocol.into_open_scad(fn_call, opts)
    end
  end
end
