defmodule Cucurbit.OpenSCAD.Transformation.Translate do
  @enforce_keys [:vector, :children]
  defstruct @enforce_keys

  def new(%Nx.Tensor{} = vector, children) when is_list(children) do
    %__MODULE__{
      vector: vector,
      children: children
    }
  end

  defimpl Cucurbit.OpenSCAD.IntoOpenSCAD do
    def into_open_scad(data, opts) do
      fn_call = %Cucurbit.OpenSCAD.FnCall{
        name: "translate",
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
