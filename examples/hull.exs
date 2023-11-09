import Nx, only: :sigils

alias Cucurbit.OpenSCAD.Sketch
alias Cucurbit.OpenSCAD.Transformation

output_path = "out/output.scad"

scene = %Transformation.Hull{
  children: [
    %Transformation.Translate{
      vector: ~V[15 10 0],
      children: [
        %Sketch.Circle{
          radius: 10,
        },
      ]
    },
    %Sketch.Circle{
      radius: 10
    }
  ]
}

Cucurbit.write(scene, output_path)
