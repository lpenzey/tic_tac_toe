defmodule TTT.IO do
  @input_output Application.get_env(:tic_tac_toe, :console_io)

  def retrieve(io \\ @input_output, message) do
    io.gets(message)
  end

  def display(io \\ @input_output, message) do
    io.puts(message)
  end
end
