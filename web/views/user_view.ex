defmodule Rumbl.UserView do
  use Rumbl.Web, :view

  def render("user.json", %{user: user}) do
    %{id: user.id, username: user.username}
  end

  def avatar(user) do
    Rumbl.Avatar.url({user.avatar, user})
  end

  def avatar_thumb(user) do
    Rumbl.Avatar.url({user.avatar, user}, :thumb)
  end
end
