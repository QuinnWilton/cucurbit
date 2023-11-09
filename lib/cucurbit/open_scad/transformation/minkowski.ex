defmodule Cucurbit.OpenSCAD.Transformation.Minkowski do
  @enforce_keys [:children]
  defstruct @enforce_keys ++ [:convexity]

  def new(children, opts \\ []) when is_list(children) do
    %__MODULE__{
      children: children,
      convexity: Keyword.get(opts, :convexity)
    }
  end

  defimpl Cucurbit.OpenSCAD.IntoOpenSCAD do
    def into_open_scad(data, opts) do
      fn_call = %Cucurbit.OpenSCAD.FnCall{
        name: "minkowski",
        args: [],
        keyword_args: [
          {"convexity", data.convexity}
        ],
        children: data.children
      }

      @protocol.into_open_scad(fn_call, opts)
    end
  end
end
