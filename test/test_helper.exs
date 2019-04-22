ExUnit.start()

defmodule MockInputOutput do
  def gets(_prompt) do
    send(self(), "retrieved user input")
  end

  def puts(_message) do
    send(self(), "output being displayed")
  end
end

defmodule MockInput do
  def analyze(move, state) do
    with {:ok, :space_on_board} <- Validity.space_on_board?(move),
         {:ok, :is_open} <- Validity.open?(move, state) do
      {:ok, :move_placed}
    else
      _ -> {:error, :need_valid_input}
    end
  end
end
