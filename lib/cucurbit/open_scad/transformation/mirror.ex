defmodule Cucurbit.OpenSCAD.Transformation.Mirror do
  @enforce_keys [:vector, :children]
  defstruct @enforce_keys

  defimpl Cucurbit.OpenSCAD.IntoOpenSCAD do
    def into_open_scad(data, opts) do
      fn_call = %Cucurbit.OpenSCAD.FnCall{
        name: "mirror",
        args: [],
        keyword_args: [
          {"v", data.vector}
        ],
        children: data.children
      }

      @protocol.into_open_scad(fn_call, opts)
    end
  end
end
