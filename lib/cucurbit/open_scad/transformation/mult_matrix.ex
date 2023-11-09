defmodule Cucurbit.OpenSCAD.Transformation.MultMatrix do
  @enforce_keys [:matrix, :children]
  defstruct @enforce_keys

  defimpl Cucurbit.OpenSCAD.IntoOpenSCAD do
    def into_open_scad(data, opts) do
      fn_call = %Cucurbit.OpenSCAD.FnCall{
        name: "multmatrix",
        args: [],
        keyword_args: [
          {"m", data.matrix}
        ],
        children: data.children
      }

      @protocol.into_open_scad(fn_call, opts)
    end
  end
end
