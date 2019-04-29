defmodule Input do
  @input_output Application.get_env(:tic_tac_toe, :console_io)

  def retrieve(input \\ @input_output, message) do
    input.gets(Output.get_message(message))
  end

  def clean(input) do
    String.trim(input)
  end

  def to_int(input) do
    try do
      String.to_integer(input)
    rescue
      ArgumentError -> {:error, :not_a_number}
    end
  end

  def sanitized_move(input) do
    clean(input)
    |> to_int()
  end
end
