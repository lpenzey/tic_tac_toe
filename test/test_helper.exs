ExUnit.start()

defmodule MockInputOutput do
  def gets(_prompt) do
    send(self(), "retrieved user input")
  end

  def puts(_message) do
    send(self(), "output being displayed")
  end
end
