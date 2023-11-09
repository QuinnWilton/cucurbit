defmodule Cucurbit do
  alias Cucurbit.OpenSCAD

  def write(data, path) do
    opts =
      Inspect.Opts.new(
        charlists: :as_lists,
        inspect_fun: &Cucurbit.OpenSCAD.IntoOpenSCAD.into_open_scad/2,
        limit: :infinity
      )

    open_scad =
      data
      |> OpenSCAD.IntoOpenSCAD.into_open_scad(opts)
      |> Inspect.Algebra.format(80)

    :ok = File.write!(path, open_scad)
  end
end
