defmodule Chat.RoomUpdateHandler do
  def init(req, opts) do
    IO.puts "update-init"
    IO.inspect req[:bindings][:room]
    room = req[:bindings][:room]
    headers = %{"content-type" => "application/json"}
    msg = wait_message(room)
    IO.puts "message:#{msg}"
    body = ~s({"content":"#{msg}","date":"my-date"})
    {:ok, resp} = :cowboy_req.reply(200, headers, body, req)
    {:ok, resp, opts}
  end

  def wait_message(room) do
    IO.puts "--- wait msg ---"
    Chat.Pubsub.subscribe(self(), room)
    message = receive do
                {:message, message} -> message
              end
    Chat.Pubsub.unsubscribe(self(), room)
    IO.puts "--- receive msg: #{inspect message} ---"
    message
  end
end
