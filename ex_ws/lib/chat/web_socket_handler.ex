defmodule Chat.WebSocketHandler do
  @behaiviour :cowboy_websocket

  def init(req, _opts) do
    room_id = req.bindings[:room_id]
    {:cowboy_websocket, req, %{room_id: room_id}}
  end

  def terminate(_reason, _req, opts) do
    Phoenix.PubSub.unsubscribe(:chat_pubsub, opts[:room_id])
    :ok
  end

  def websocket_init(opts) do
    Phoenix.PubSub.subscribe(:chat_pubsub, opts[:room_id])
    {:ok, opts}
  end

  def websocket_handle({:text, content}, opts) do
    Phoenix.PubSub.broadcast(:chat_pubsub, opts[:room_id], {:text, content})
    {:ok, opts}
  end
  def websocket_handle(_frame, opts), do: {:ok, opts}

  def websocket_info({:text, content}, opts), do: {:reply, {:text, content}, opts}
  def websocket_info(_info, opts), do: {:ok, opts}
end
