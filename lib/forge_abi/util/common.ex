defmodule ForgeAbi.Util do
  @moduledoc """
  Common functionality for ABI related stuff
  """

  @doc """
  Retrieve the nested default value for mod
  """
  def get_default(mod) do
    data = mod.new()

    data
    |> Map.from_struct()
    |> Map.keys()
    |> Enum.reduce(data, fn key, data ->
      props = data.__struct__.__message_props__
      field_mod = get_field_mod(props, key)

      case Kernel.function_exported?(field_mod, :new, 0) do
        true -> Map.put(data, key, get_default(field_mod))
        _ -> data
      end
    end)
  end

  defp get_field_mod(props, key) do
    field = Map.get(props.field_props, Map.get(props.tags_map, Map.get(props.field_tags, key)))
    field.type
  end
end
