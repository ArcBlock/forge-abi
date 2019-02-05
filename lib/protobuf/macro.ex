defmodule ForgeAbi.EnumFields do
  @moduledoc """
  Workaround to inject a `fields` function into enum
  """

  defmacro __using__(_opts) do
    quote do
      def fields, do: @fields |> Enum.map(&elem(&1, 0))
    end
  end
end
