# Custom type for video
#
defmodule Rumbl.Permalink do
  @behaviour Ecto.Type

  # Returns the underlying Ecto type.
  # In thes case, we're building on top of :id
  def type do
    :id
  end

  # Called when external data is passed into Ecto.
  # It's invoked when values in queries are interpolated
  # or also by the `cast` function in changeset
  #
  def cast(binary) when is_binary(binary) do
    case Integer.parse(binary) do
      {int,_} when int > 0 -> {:ok, int}
      _ -> :error
    end
  end

  def cast(integer) when is_integer(integer) do
    {:ok, integer}
  end

  def cast(_) do
    :error
  end

  # Invoked when data is sent to the database
  #
  def dump(integer) when is_integer(integer) do
    {:ok, integer}
  end

  # Invoked when data is loaded form the database
  #
  def load(integer) when is_integer(integer) do
    {:ok, integer}
  end
end
