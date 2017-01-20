defmodule LongPolling.DataHandler do
  def init(req, opts) do
    #IO.puts "/data"
    room = req[:bindings][:room]

    LongPolling.Pubsub.subscribe(room)

    headers = %{"content-type" => "application/json"}
    body = ~s({"content":"data-end-datahandler"})
    {:ok, resp} = :cowboy_req.reply(200, headers, body, req)
    {:ok, resp, opts}
  end
end
