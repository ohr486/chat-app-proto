defmodule LongPolling.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(__MODULE__, [], function: :run)
    ]

    opts = [strategy: :one_for_one, name: LongPolling.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def run do
    routes = [
      {"/", LongPolling.Handler, []},
      #{"/poll", LongPolling.LpEventHandler, []},
      {"/static/[...]", :cowboy_static, {:priv_dir, :long_polling, "static_files"}}
    ]

    dispatch = :cowboy_router.compile([{:_, routes}])

    opts = [{:port, 4000}]
    env = %{dispatch: dispatch}

    {:ok, _pid} = :cowboy.start_clear(:http, 100, opts, %{env: env})
  end
end
