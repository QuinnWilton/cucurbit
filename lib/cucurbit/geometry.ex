defmodule Cucurbit.Geometry do
  alias Cucurbit.OpenSCAD.Body
  alias Cucurbit.OpenSCAD.Sketch

  def sphere(radius, opts \\ []) do
    Body.Sphere.new(radius, opts)
  end

  def circle(radius, opts \\ []) do
    Sketch.Circle.new(radius, opts)
  end

  def cube(size, opts \\ [])
  def cube({x, y, z}, opts), do: cube(Nx.tensor([x, y, z]), opts)

  def cube(%Nx.Tensor{} = size, opts) do
    Body.Cube.new(size, opts)
  end

  def rectangle(size, opts \\ [])
  def rectangle({x, y}, opts), do: rectangle(Nx.tensor([x, y]), opts)

  def rectangle(%Nx.Tensor{} = size, opts) do
    Sketch.Square.new(size, opts)
  end
end
