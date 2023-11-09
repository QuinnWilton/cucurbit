defmodule Cucurbit.OpenSCAD.Body.LinearExtrude do
  @enforce_keys [:height]
  defstruct @enforce_keys ++ [:"$fn", :twist, :center, :scale, :convexity, :slices, children: []]

  def new(children, height, opts \\ []) when is_list(children) do
    %__MODULE__{
      height: height,
      children: children,
      twist: Keyword.get(opts, :twist),
      center: Keyword.get(opts, :center),
      scale: Keyword.get(opts, :scale),
      convexity: Keyword.get(opts, :convexity),
      slices: Keyword.get(opts, :slices),
      "$fn": Keyword.get(opts, :"$fn")
    }
  end

  defimpl Cucurbit.OpenSCAD.IntoOpenSCAD do
    def into_open_scad(data, opts) do
      fn_call = %Cucurbit.OpenSCAD.FnCall{
        name: "linear_extrude",
        args: [],
        keyword_args: [
          {"height", data.height},
          {"$fn", data."$fn"},
          {"twist", data.twist},
          {"center", data.center},
          {"scale", data.scale},
          {"convexity", data.convexity},
          {"slices", data.slices}
        ],
        children: data.children
      }

      @protocol.into_open_scad(fn_call, opts)
    end
  end
end
