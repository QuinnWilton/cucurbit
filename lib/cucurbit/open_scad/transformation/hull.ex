defmodule Cucurbit.OpenSCAD.Transformation.Hull do
  @enforce_keys [:children]
  defstruct @enforce_keys

  def new(children) when is_list(children) do
    %__MODULE__{
      children: children
    }
  end

  defimpl Cucurbit.OpenSCAD.IntoOpenSCAD do
    def into_open_scad(data, opts) do
      fn_call = %Cucurbit.OpenSCAD.FnCall{
        name: "hull",
        args: [],
        keyword_args: [],
        children: data.children
      }

      @protocol.into_open_scad(fn_call, opts)
    end
  end
end
