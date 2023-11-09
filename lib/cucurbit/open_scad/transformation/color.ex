defmodule Cucurbit.OpenSCAD.Transformation.Color do
  @enforce_keys [:color, :children]
  defstruct @enforce_keys

  def new(color, children) when is_list(children) do
    %__MODULE__{
      color: color,
      children: children
    }
  end

  defimpl Cucurbit.OpenSCAD.IntoOpenSCAD do
    def into_open_scad(data, opts) do
      fn_call = %Cucurbit.OpenSCAD.FnCall{
        name: "color",
        args: [data.color],
        keyword_args: [],
        children: data.children
      }

      @protocol.into_open_scad(fn_call, opts)
    end
  end
end
