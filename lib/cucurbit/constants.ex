defmodule Cucurbit.Constants do
  import Nx, only: :sigils

  def zero(), do: ~V[0 0 0]

  def left(), do: ~V[-1 0 0]
  def right(), do: ~V[1 0 0]
  def forward(), do: ~V[0 -1 0]
  def backward(), do: ~V[0 1 0]
  def down(), do: ~V[0 0 -1]
  def up(), do: ~V[0 0 1]
end
