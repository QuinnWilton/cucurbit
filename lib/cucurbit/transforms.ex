defmodule Cucurbit.Transforms do
  alias Cucurbit.Constants
  alias Cucurbit.OpenSCAD.Transformation.Color
  alias Cucurbit.OpenSCAD.Transformation.Hull
  alias Cucurbit.OpenSCAD.Transformation.Minkowski
  alias Cucurbit.OpenSCAD.Transformation.Resize
  alias Cucurbit.OpenSCAD.Transformation.Rotate
  alias Cucurbit.OpenSCAD.Transformation.Scale
  alias Cucurbit.OpenSCAD.Transformation.Translate

  def color(node, color), do: Color.new(color, [node])

  def move(node, {x, z, y}), do: move(node, Nx.tensor([x, z, y]))
  def move(node, %Nx.Tensor{} = vector), do: Translate.new(vector, [node])
  def xmove(node, x), do: move(node, Nx.multiply(x, Constants.right()))
  def ymove(node, y), do: move(node, Nx.multiply(y, Constants.backward()))
  def zmove(node, z), do: move(node, Nx.multiply(z, Constants.up()))

  def left(node, x), do: xmove(node, -x)
  def right(node, x), do: xmove(node, x)
  def forward(node, y), do: ymove(node, -y)
  def backward(node, y), do: ymove(node, y)
  def down(node, z), do: zmove(node, -z)
  def up(node, z), do: zmove(node, z)

  def rotate(node, {x, z, y}), do: rotate(node, Nx.tensor([x, z, y]))
  def rotate(node, %Nx.Tensor{} = vector), do: Rotate.new(vector, [node])
  def xrotate(node, x), do: rotate(node, Nx.tensor([x, 0, 0]))
  def yrotate(node, y), do: rotate(node, Nx.tensor([0, y, 0]))
  def zrotate(node, z), do: rotate(node, Nx.tensor([0, 0, z]))

  def scale(node, {x, z, y}), do: scale(node, Nx.tensor([x, z, y]))
  def scale(node, %Nx.Tensor{} = vector), do: Scale.new(vector, [node])
  def xscale(node, x), do: scale(node, Nx.tensor([x, 1, 1]))
  def yscale(node, y), do: scale(node, Nx.tensor([1, y, 1]))
  def zscale(node, z), do: scale(node, Nx.tensor([1, 1, z]))

  def resize(node, vector, opts \\ [])
  def resize(node, {x, z, y}, opts), do: resize(node, Nx.tensor([x, z, y]), opts)
  def resize(node, %Nx.Tensor{} = vector, opts), do: Resize.new(vector, [node], opts)
  def xresize(node, x), do: resize(node, Nx.tensor([x, 0, 0]), auto: [true, false, false])
  def yresize(node, y), do: resize(node, Nx.tensor([0, y, 0]), auto: [false, true, false])
  def zresize(node, z), do: resize(node, Nx.tensor([0, 0, z]), auto: [false, false, true])

  def hull(nodes), do: Hull.new(nodes)
  def minkowski(nodes, opts \\ []), do: Minkowski.new(nodes, opts)

  def place_copies(node, offsets) when is_list(offsets) do
    Enum.map(offsets, fn offset ->
      Translate.new(offset, [node])
    end)
  end
end
