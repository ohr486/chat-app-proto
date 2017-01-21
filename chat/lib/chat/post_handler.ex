defmodule Chat.PostHandler do
  def init(req, opts) do
    room = req[:bindings][:room]
    message = req[:bindings][:message]
    headers = %{"content-type" => "application/json"}
    Chat.Pubsub.publish(room, message)
    body = ~s({"result":"success"})
    {:ok, resp} = :cowboy_req.reply(200, headers, body, req)
    {:ok, resp, opts}
  end
end
