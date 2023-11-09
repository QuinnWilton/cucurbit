defmodule Cucurbit.OpenSCAD.Sketch.Square do
  @enforce_keys [:size]
  defstruct @enforce_keys ++ [:center]

  @type t :: %__MODULE__{
          size: pos_integer() | Nx.Tensor.t(),
          center: boolean()
        }

  def new(%Nx.Tensor{} = size, opts \\ []) do
    %__MODULE__{
      size: size,
      center: Keyword.get(opts, :center)
    }
  end

  defimpl Cucurbit.OpenSCAD.IntoOpenSCAD do
    def into_open_scad(data, opts) do
      fn_call = %Cucurbit.OpenSCAD.FnCall{
        name: "square",
        args: [],
        keyword_args: [
          {"size", data.size},
          {"center", data.center}
        ]
      }

      @protocol.into_open_scad(fn_call, opts)
    end
  end
end
