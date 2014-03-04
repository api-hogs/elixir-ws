defmodule WebSocketServer do
  @behaviour :application

  def start(_type, _args) do
		Redis.start
    dispatch = :cowboy_router.compile([
      {:_, [
        {'/ws',    HelloHandler, []}
      ]}
    ])
    :cowboy.start_http :my_http_listener, 100, [{:port, 4000}], [{:env, [{:dispatch, dispatch}]}]
    IO.puts "Started listening on port 4000..."
    WebSocketSup.start_link
  end

  def stop(_state) do
    :ok
  end
end
