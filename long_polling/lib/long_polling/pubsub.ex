defmodule LongPolling.Pubsub do
  use GenServer

  def init(args) do
    IO.puts "--- Pubsub#init ---"
    :gproc.reg({:p, :l, args[:topic]})
    {:ok, []}
  end

  def handle_info(msg, state) do
    IO.inspect "--- Got #{inspect msg} in process #{inspect self()} ---"
    {:noreply, state}
  end

  def subscribe(topic) do
    IO.puts "--- Pubsub#subscribe ---"
    :gproc.reg({:p, :l, topic})
  end

  def subscribers(topic) do
    IO.puts "--- Pubsub#subscribers:#{inspect topic} ---"
    :gproc.lookup_pids({:p, :l, topic})
  end

  def broadcast(topic, msg) do
    IO.puts "--- Pubsub#broadcast:#{inspect topic}:#{inspect msg} ---"
    :gproc.send({:p, :l, topic}, msg)
  end
end
