defmodule Cucurbit.OpenSCAD.Transformation.Resize do
  @enforce_keys [:new_size, :auto, :children]
  defstruct @enforce_keys

  def new(%Nx.Tensor{} = new_size, children, opts \\ []) when is_list(children) do
    %__MODULE__{
      new_size: new_size,
      children: children,
      auto: Keyword.get(opts, :auto)
    }
  end

  defimpl Cucurbit.OpenSCAD.IntoOpenSCAD do
    def into_open_scad(data, opts) do
      fn_call = %Cucurbit.OpenSCAD.FnCall{
        name: "resize",
        args: [],
        keyword_args: [
          {"newsize", data.new_size},
          {"auto", data.auto}
        ],
        children: data.children
      }

      @protocol.into_open_scad(fn_call, opts)
    end
  end
end
