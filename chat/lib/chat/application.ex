defmodule Chat.Application do
  @moduledoc false
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(__MODULE__, [], function: :run),
      worker(Chat.Pubsub, [])
    ]

    opts = [strategy: :one_for_one, name: Chat.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def run do
    routes = [
      {"/", Chat.Handler, []},
      {"/room/:room/message/:message", Chat.PostHandler, []},
      {"/room/:room", Chat.RoomHandler, []},
      {"/room-update/:room", Chat.RoomUpdateHandler, []},
      {"/static/[...]", :cowboy_static, {:priv_dir, :chat, "static_files"}}
    ]
    dispatch = :cowboy_router.compile([{:_, routes}])
    opts = [{:port, 4000}]
    env = %{dispatch: dispatch}
    {:ok, _pid} = :cowboy.start_clear(:http, 100, opts, %{env: env})
  end
end
