defmodule Chat.HelloHandler do
  def init(req, opts) do
    headers = %{"content-type" => "text/plain"}
    body = "Hello, Cowboy Long Polling!"
    {:ok, resp} = :cowboy_req.reply(200, headers, body, req)
    {:ok, resp, opts}
  end
end
