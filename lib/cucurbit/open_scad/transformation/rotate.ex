defmodule Cucurbit.OpenSCAD.Transformation.Rotate do
  @enforce_keys [:children]
  defstruct @enforce_keys ++ [:a]

  def new(a, children) when is_list(children) do
    %__MODULE__{
      a: a,
      children: children
    }
  end

  defimpl Cucurbit.OpenSCAD.IntoOpenSCAD do
    def into_open_scad(data, opts) do
      fn_call = %Cucurbit.OpenSCAD.FnCall{
        name: "rotate",
        args: [],
        keyword_args: [
          {"a", data.a}
        ],
        children: data.children
      }

      @protocol.into_open_scad(fn_call, opts)
    end
  end
end
