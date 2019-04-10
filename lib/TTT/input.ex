defmodule Input do
  def retrieve do
    IO.stream(:stdio, :line)
  end

  def clean(input) do
    String.trim(input)
  end

  def process_move(move, state) do
    cond do
      !Validity.number?(move) ->
        Output.get_message(:nan)
        |> IO.puts()

        state

      !Validity.user_move_to_internal_state(move) ->
        Output.get_message(:nonexistant_space)
        |> IO.puts()

        state

      !Validity.open?(move, state) ->
        Output.get_message(:space_taken)
        |> IO.puts()

        state

      true ->
        Validity.user_move_to_internal_state(move)
        |> State.set_move(state)
    end
  end
end
