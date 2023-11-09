defmodule Cucurbit.OpenSCAD.Sketch.Import do
  @enforce_keys [:file]
  defstruct @enforce_keys ++ [:convexity, :layer, :"$fa", :"$fs", :"$fn"]

  def new(file, opts \\ []) when is_binary(file) do
    %__MODULE__{
      file: file,
      convexity: Keyword.get(opts, :convexity),
      layer: Keyword.get(opts, :layer),
      "$fa": Keyword.get(opts, :"$fa"),
      "$fs": Keyword.get(opts, :"$fs"),
      "$fn": Keyword.get(opts, :"$fn")
    }
  end

  defimpl Cucurbit.OpenSCAD.IntoOpenSCAD do
    def into_open_scad(data, opts) do
      fn_call = %Cucurbit.OpenSCAD.FnCall{
        name: "import",
        args: [data.file],
        keyword_args: [
          {"convexity", data.convexity},
          {"layer", data.layer},
          {"$fa", data."$fa"},
          {"$fs", data."$fs"},
          {"$fn", data."$fn"}
        ]
      }

      @protocol.into_open_scad(fn_call, opts)
    end
  end
end
