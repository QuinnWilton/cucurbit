defprotocol Cucurbit.OpenSCAD.IntoOpenSCAD do
  @fallback_to_any true

  def into_open_scad(data, opts)
end

defimpl Cucurbit.OpenSCAD.IntoOpenSCAD, for: Any do
  def into_open_scad(data, opts) do
    Inspect.inspect(data, opts)
  end
end

defimpl Cucurbit.OpenSCAD.IntoOpenSCAD, for: Nx.Tensor do
  def into_open_scad(data, opts) do
    data =
      case Nx.shape(data) do
        {} ->
          Nx.to_number(data)

        _ ->
          Nx.to_list(data)
      end

    Inspect.inspect(data, opts)
  end
end

defmodule Cucurbit.OpenSCAD.FnCall do
  @enforce_keys [:name, :args, :keyword_args]
  defstruct @enforce_keys ++ [children: []]

  defimpl Cucurbit.OpenSCAD.IntoOpenSCAD do
    import Inspect.Algebra

    def into_open_scad(fn_call, opts) do
      args =
        Enum.filter(fn_call.args ++ fn_call.keyword_args, fn
          {_, value} -> value != nil
          _ -> true
        end)

      args_sep = color(" = ", :map, opts)
      fun = &to_args(&1, &2, args_sep)

      open = color("(", :map, opts)
      sep = color(",", :map, opts)
      close = color(")", :map, opts)

      fn_call_doc =
        concat(
          string(fn_call.name),
          container_doc(open, args, close, opts, fun, separator: sep, break: :strict)
        )

      if Enum.empty?(fn_call.children) do
        concat(fn_call_doc, string(";"))
      else
        concat(
          fn_call_doc,
          container_doc(
            color(" {", :map, opts),
            fn_call.children,
            color("}", :map, opts),
            opts,
            &to_doc/2,
            separator: "",
            break: :strict
          )
        )
      end
    end

    defp to_args({key, value}, opts, sep) do
      concat(concat(string(key), sep), to_doc(value, opts))
    end

    defp to_args(arg, opts, _sep) do
      to_doc(arg, opts)
    end
  end
end
