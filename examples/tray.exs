import Nx, only: :sigils

alias Cucurbit.OpenSCAD.Body
alias Cucurbit.OpenSCAD.CSG
alias Cucurbit.OpenSCAD.Sketch
alias Cucurbit.OpenSCAD.Transformation

defmodule ParametricTray do
  def scene(tray_size_x, tray_size_y, regions) do
    {num_rows, num_cols} = Nx.shape(regions)

    wall_height = 20
    wall_thickness = 10

    cell_size_x = (tray_size_x - wall_thickness * (num_cols + 1)) / num_cols
    cell_size_y = (tray_size_y - wall_thickness * (num_rows + 1)) / num_rows

    cells =
      for row <- 0..(num_rows - 1) do
        for col <- 0..(num_cols - 1) do
          x = col * (cell_size_x + wall_thickness) + wall_thickness
          y = row * (cell_size_y + wall_thickness) + wall_thickness

          chamfer = %Body.Sphere{
            radius: wall_thickness / 4
          }

          cell = %Transformation.Translate{
            vector: Nx.tensor([x, y, wall_thickness]),
            children: [
              %Transformation.Minkowski{
                children: [
                  %Body.Cube{
                    size: Nx.tensor([cell_size_x, cell_size_y, wall_height])
                  },
                  chamfer
                ]
              }
            ]
          }

          {row, col, cell}
        end
      end

    cells =
      cells
      |> List.flatten()
      |> Enum.reduce(%{}, fn {row, col, cell}, acc ->
        region = Nx.to_number(regions[row][col])

        Map.update(acc, region, [cell], fn cells -> [cell | cells] end)
      end)
      |> Enum.map(fn {_, cells} ->
        %Transformation.Hull{
          children: cells
        }
      end)

    tray = %Transformation.Minkowski{
      children: [
        %Body.Cube{
          size: Nx.tensor([tray_size_x, tray_size_y, wall_height])
        },
        %Body.Sphere{
          radius: wall_thickness / 4
        }
      ]
    }

    tray = %CSG.Difference{
      children: [tray | cells]
    }

    scene = %Cucurbit.Scene{
      children: [tray]
    }
  end
end

tray_size_x = 100
tray_size_y = 175

regions = ~M'''
1 1 2 3
1 1 2 3
1 1 2 3
'''

scene =
  ParametricTray.scene(
    tray_size_x,
    tray_size_y,
    regions
  )

Cucurbit.write(scene, "out/output.scad")
