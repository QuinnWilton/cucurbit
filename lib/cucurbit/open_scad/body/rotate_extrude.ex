defmodule Cucurbit.OpenSCAD.Body.RotateExtrude do
  @enforce_keys []
  defstruct @enforce_keys ++ [:convexity, :angle, :"$fa", :"$fs", :"$fn", children: []]

  def new(children, opts \\ []) when is_list(children) do
    %__MODULE__{
      children: children,
      convexity: Keyword.get(opts, :convexity),
      angle: Keyword.get(opts, :angle),
      "$fa": Keyword.get(opts, :"$fa"),
      "$fs": Keyword.get(opts, :"$fs"),
      "$fn": Keyword.get(opts, :"$fn")
    }
  end

  defimpl Cucurbit.OpenSCAD.IntoOpenSCAD do
    def into_open_scad(data, opts) do
      fn_call = %Cucurbit.OpenSCAD.FnCall{
        name: "rotate_extrude",
        args: [],
        keyword_args: [
          {"convexity", data.convexity},
          {"angle", data.angle},
          {"$fa", data."$fa"},
          {"$fs", data."$fs"},
          {"$fn", data."$fn"}
        ],
        children: data.children
      }

      @protocol.into_open_scad(fn_call, opts)
    end
  end
end
