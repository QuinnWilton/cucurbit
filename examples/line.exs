import Nx, only: :sigils

alias Cucurbit.OpenSCAD.Body
alias Cucurbit.Transforms

scene = %Body.Cube{
  size: Nx.tensor([10, 10, 10])
} |> Transforms.place_copies([~V[0 0 0], ~V[20 0 0]])

scene = %Cucurbit.Scene{
  children: scene
}

Cucurbit.write(scene, "out/output.scad")
