defmodule Cucurbit.OpenSCAD.Body.Cylinder do
  @enforce_keys [:height]
  defstruct @enforce_keys ++ [:r, :r1, :r2, :center, :"$fa", :"$fs", :"$fn"]

  defimpl Cucurbit.OpenSCAD.IntoOpenSCAD do
    def into_open_scad(data, opts) do
      fn_call = %Cucurbit.OpenSCAD.FnCall{
        name: "cylinder",
        args: [],
        keyword_args: [
          {"h", data.height},
          {"r", data.r},
          {"r1", data.r1},
          {"r2", data.r2},
          {"center", data.center},
          {"$fa", data."$fa"},
          {"$fs", data."$fs"},
          {"$fn", data."$fn"}
        ]
      }

      @protocol.into_open_scad(fn_call, opts)
    end
  end
end
