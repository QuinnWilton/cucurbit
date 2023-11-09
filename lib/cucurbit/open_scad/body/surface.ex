defmodule Cucurbit.OpenSCAD.Body.Surface do
  @enforce_keys [:file]
  defstruct @enforce_keys ++ [:center, :invert, :convexity]

  defimpl Cucurbit.OpenSCAD.IntoOpenSCAD do
    def into_open_scad(data, opts) do
      fn_call = %Cucurbit.OpenSCAD.FnCall{
        name: "surface",
        args: [data.file],
        keyword_args: [
          {"center", data.center},
          {"invert", data.invert},
          {"convexity", data.convexity}
        ]
      }

      @protocol.into_open_scad(fn_call, opts)
    end
  end
end
