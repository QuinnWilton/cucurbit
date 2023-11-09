defmodule Cucurbit.OpenSCAD.Sketch.Projection do
  @enforce_keys [:cut, :children]
  defstruct @enforce_keys

  def new(children, opts \\ []) when is_list(children) do
    %__MODULE__{
      children: children,
      cut: Keyword.get(opts, :cut)
    }
  end

  defimpl Cucurbit.OpenSCAD.IntoOpenSCAD do
    def into_open_scad(data, opts) do
      fn_call = %Cucurbit.OpenSCAD.FnCall{
        name: "projection",
        args: [],
        keyword_args: [
          {"cut", data.cut}
        ],
        children: data.children
      }

      @protocol.into_open_scad(fn_call, opts)
    end
  end
end
