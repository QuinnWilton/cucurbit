defmodule Cucurbit.OpenSCAD.Sketch.Circle do
  @enforce_keys [:radius]
  defstruct @enforce_keys ++ [:"$fa", :"$fs", :"$fn"]

  def new(radius, opts \\ []) do
    %__MODULE__{
      radius: radius,
      "$fa": Keyword.get(opts, :"$fa"),
      "$fs": Keyword.get(opts, :"$fs"),
      "$fn": Keyword.get(opts, :"$fn")
    }
  end

  defimpl Cucurbit.OpenSCAD.IntoOpenSCAD do
    def into_open_scad(data, opts) do
      fn_call = %Cucurbit.OpenSCAD.FnCall{
        name: "circle",
        args: [],
        keyword_args: [
          {"r", data.radius},
          {"$fa", data."$fa"},
          {"$fs", data."$fs"},
          {"$fn", data."$fn"}
        ]
      }

      @protocol.into_open_scad(fn_call, opts)
    end
  end
end
