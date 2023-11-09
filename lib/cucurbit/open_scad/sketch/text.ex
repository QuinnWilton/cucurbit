defmodule Cucurbit.OpenSCAD.Sketch.Text do
  @enforce_keys [:text]
  defstruct @enforce_keys ++
              [:size, :font, :halign, :valign, :spacing, :direction, :language, :script, :"$fn"]

  defimpl Cucurbit.OpenSCAD.IntoOpenSCAD do
    def into_open_scad(data, opts) do
      fn_call = %Cucurbit.OpenSCAD.FnCall{
        name: "text",
        args: [],
        keyword_args: [
          {"text", data.text},
          {"size", data.size},
          {"font", data.font},
          {"halign", data.halign},
          {"valign", data.valign},
          {"spacing", data.spacing},
          {"direction", data.direction},
          {"language", data.language},
          {"script", data.script},
          {"$fn", data."$fn"}
        ]
      }

      @protocol.into_open_scad(fn_call, opts)
    end
  end
end
