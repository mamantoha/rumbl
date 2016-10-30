defmodule Rumbl.VideoChannel do
  use Rumbl.Web, :channel

  def join("videos:" <> video_id, _params, socket) do
    # :timer.send_interval(5_000, :ping)
    {:ok, socket}
  end

  # The `handle_info` callback is invoked whenever an Elixir message
  # reaches the channel
  # def handle_info(:ping, socket) do
  #   count = socket.assigns[:count] || 1
  #   push socket, "ping", %{count: count}
  #
  #   {:noreply, assign(socket, :count, count+1)}
  # end

  def handle_in("new_annotation", params, socket) do
    broadcast! socket, "new_annotation", %{
      user: %{username: "annon"},
      body: params["body"],
      at: params["at"],
      params: params
    }

    {:reply, :ok, socket}
  end

end
