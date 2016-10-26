defmodule Rumbl.Repo do
  # use Ecto.Repo, otp_app: :rumbl

  @moduledoc """
  In memory repository
  """

  def all(Rumbl.User) do
    [
      %Rumbl.User{id: 1, name: "Anton", username: "anton", password: "111"},
      %Rumbl.User{id: 2, name: "Katya", username: "katya", password: "111"},
      %Rumbl.User{id: 3, name: "Sofie", username: "sofie", password: "111"},
      %Rumbl.User{id: 4, name: "Chris", username: "chris", password: "111"}
    ]
  end

  def all(_module), do: []

  def get(module, id) do
    Enum.find all(module), fn map -> map.id == id end
  end


  def get_by(module, params) do
    Enum.find all(module), fn map ->
      Enum.all?(params, fn {key, value} -> Map.get(map, key) == value end)
    end
  end
end
