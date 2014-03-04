defmodule WebSocket.Mixfile do
  use Mix.Project

  def project do
    [ app: :web_socket,
      version: "0.0.1",
      deps: deps ]
  end

 	def application do
    [
      applications: [:ranch, :crypto, :cowboy, :gproc],
      mod: {WebSocketServer, []},
    ]
  end

  # Returns the list of dependencies in the format:
  # { :foobar, "0.1", git: "https://github.com/elixir-lang/foobar.git" }
  defp deps do
    [
      {:cowboy, github: "extend/cowboy"},
      {:gproc, github: "esl/gproc"},
			{ :redis, "1.1.0", [ github: "timbuchwaldt/elixir-redis"]}
    ]
  end
end
