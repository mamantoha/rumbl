defmodule Rumbl.WatchController do
  use Rumbl.Web, :controller

  alias Rumbl.Video

  def index(conn, _params) do
    videos = Repo.all Video

    render conn, "index.html", videos: videos
  end

  def show(conn, %{"id" => id}) do
    video = Repo.get!(Video, id)
    render conn, "show.html", video: video
  end
end
