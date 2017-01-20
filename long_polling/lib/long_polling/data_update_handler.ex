defmodule LongPolling.DataUpdateHandler do
  def init(req, opts) do
    #IO.puts "/data-update"
    room = req[:bindings][:room]

    headers = %{"content-type" => "application/json"}
    now = :erlang.time
    body = ~s({"content":"my-cont","date":"#{elem(now,0)}:#{elem(now,1)}:#{elem(now,2)}"})
  
    :timer.sleep(1000)

    LongPolling.Pubsub.broadcast(room, body)
    {:ok, resp} = :cowboy_req.reply(200, headers, body, req)
    {:ok, resp, opts}
  end
end
