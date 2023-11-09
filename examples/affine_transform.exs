alias Cucurbit.OpenSCAD.Body
alias Cucurbit.OpenSCAD.Transformation

output_path = "out/output.scad"

t =
  Nx.tensor([
    [1, 0, 0, 10],
    [0, 1, 0, 0],
    [0, 0, 1, 0],
    [0, 0, 0, 1]
  ])

r =
  Nx.tensor([
    [:math.cos(45), 0, :math.sin(45), 0],
    [0, 1, 0, 0],
    [-:math.sin(45), 0, :math.cos(45), 0],
    [0, 0, 0, 1]
  ])

b = Nx.dot(r, t)

scene = %Transformation.MultMatrix{
  matrix: b,
  children: [
    %Body.Cube{
      size: 10,
      center: true
    }
  ]
}

Cucurbit.write(scene, output_path)
