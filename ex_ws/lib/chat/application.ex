defmodule Chat.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(__MODULE__, [], function: :run),
      supervisor(Phoenix.PubSub.Redis, [:chat_pubsub, [pool_size: 1, node_name: :chat_pubsub]])
    ]

    opts = [strategy: :one_for_one, name: Chat.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def run do
    routes = [
      {"/", Chat.HelloHandler, []},
      {"/websocket", Chat.WebSocketHandler, []},
      {"/static/[...]", :cowboy_static, {:priv_dir, :chat, "static_files"}}
    ]
    dispatch = :cowboy_router.compile([{:_, routes}])
    opts = [{:port, 4000}]
    env = %{dispatch: dispatch}
    {:ok, _pid} = :cowboy.start_clear(:http, 100, opts, %{env: env})
  end
end
