import Nx, only: :sigils

alias Cucurbit.OpenSCAD.Body
alias Cucurbit.OpenSCAD.Sketch
alias Cucurbit.OpenSCAD.Transformation

output_path = "out/output.scad"

scene =
  %Body.LinearExtrude{
    height: 10,
    center: true,
    twist: Enum.random(-100..-75),
    convexity: 10,
    children: [
      %Transformation.Translate{
        vector: ~V[2 0 0],
        children: [
          %Sketch.Circle{
            radius: 1
          }
        ]
      }
    ]
  }

Cucurbit.write(scene, output_path)
