defmodule Cucurbit.DSL do
  alias Cucurbit.OpenSCAD.Body
  alias Cucurbit.OpenSCAD.CSG
  alias Cucurbit.OpenSCAD.Sketch

  defmacro __using__(_) do
    quote do
      import Nx, only: :sigils

      import Cucurbit.DSL
      import Cucurbit.Geometry
      import Cucurbit.Scene, only: [add_child: 2]
      import Cucurbit.Transforms
    end
  end

  def import_file(file, opts \\ []) when is_binary(file) do
    Sketch.Import.new(file, opts)
  end

  def projection(node, opts \\ []) do
    Sketch.Projection.new([node], opts)
  end

  def linear_extrude(node, height, opts \\ []) do
    Body.LinearExtrude.new([node], height, opts)
  end

  def rotate_extrude(node, opts \\ []) do
    Body.RotateExtrude.new([node], opts)
  end

  def union(children) when is_list(children) do
    CSG.Union.new(children)
  end

  def difference(children) when is_list(children) do
    CSG.Difference.new(children)
  end

  def intersection(children) when is_list(children) do
    CSG.Intersection.new(children)
  end
end
