defmodule Chat.RoomHandler do
  def init(req, opts) do
    room = req[:bindings][:room]
    headers = %{"content-type" => "application/json"}
    body = ~s({"content":"join-room:#{room}"})
    {:ok, resp} = :cowboy_req.reply(200, headers, body, req)
    {:ok, resp, opts}
  end
end
