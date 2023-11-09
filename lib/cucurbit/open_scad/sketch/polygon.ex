defmodule Cucurbit.OpenSCAD.Sketch.Polygon do
  @enforce_keys [:points]
  defstruct @enforce_keys ++ [:paths, :convexity]

  defimpl Cucurbit.OpenSCAD.IntoOpenSCAD do
    def into_open_scad(data, opts) do
      fn_call = %Cucurbit.OpenSCAD.FnCall{
        name: "polygon",
        args: [],
        keyword_args: [
          {"points", data.points},
          {"paths", data.paths},
          {"convexity", data.convexity}
        ]
      }

      @protocol.into_open_scad(fn_call, opts)
    end
  end
end
