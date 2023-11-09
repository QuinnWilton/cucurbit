import Nx, only: :sigils

alias Cucurbit.OpenSCAD.Body
alias Cucurbit.OpenSCAD.Sketch
alias Cucurbit.OpenSCAD.Transformation

output_path = "out/output.scad"

scene = %Body.RotateExtrude{
  convexity: 10,
  "$fn": 100,
  children: [
    %Transformation.Translate{
      vector: ~V[2 0 0],
      children: [
        %Sketch.Circle{
          radius: 1,
        },
      ]
    },
  ]
}

Cucurbit.write(scene, output_path)
