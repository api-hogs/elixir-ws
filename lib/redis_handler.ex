defmodule RedisHandler do
  @behaviour :cowboy_http_handler
	@behaviour :cowboy_websocket_handler
  @moduledoc """
  This is a stub handler
  """

	def init({:tcp, :http}, _req, _opts), do: { :upgrade, :protocol, :cowboy_websocket }
	def websocket_init(_transport_name, req, _opts) do
				req = set_cors(req)
	      { :ok, req, :no_state }
	end

	def websocket_info({ :message, message }, req, state) do
			  req = set_cors(req)
	      { :reply, { :text, check_redis_value(message) }, req, state }
	end

	def websocket_handle({ :text, message }, req, state) do
				req = set_cors(req)
				:timer.send_interval(3000, {:message, message })
	      { :ok, req, :no_state }
	end
	def websocket_terminate(_reason, _req, _state), do: :ok

	defp check_redis_value(key) do
		a = Redis.get(key)
		a = case a do
			:undefined 	-> "session time out"
			_  					-> a
		end
		a
	end

	defp set_cors(req) do
		req = :cowboy_req.set_resp_header("access-control-allow-methods", "GET, OPTIONS", req)
		req = :cowboy_req.set_resp_header("access-control-allow-origin", "*", req)
		req
	end

end
