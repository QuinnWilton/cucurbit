defmodule Cucurbit.Scene do
  @enforce_keys [:children]
  defstruct @enforce_keys

  def new() do
    %__MODULE__{
      children: []
    }
  end

  def add_child(scene, child) do
    %__MODULE__{
      scene
      | children: scene.children ++ [child]
    }
  end

  defimpl Cucurbit.OpenSCAD.IntoOpenSCAD do
    import Inspect.Algebra

    def into_open_scad(data, opts) do
      container_doc("", data.children, "", opts, &to_doc/2, separator: "", break: :strict)
    end
  end
end
