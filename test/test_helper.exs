ExUnit.start()

defmodule MockTTT.IO do
  def retrieve(message) do
    gets(message)
  end

  def gets(_prompt) do
    Helpers.Stack.pop()
  end
end

defmodule MockPlayer do
  def choose_token(_deps) do
    "X"
  end
end

defmodule MockValidation do
  def clean(input) do
    String.trim(input)
  end

  def sanitized_move(input) do
    clean(input)
    |> to_int()
  end

  def to_int(input) do
    try do
      String.to_integer(input)
    rescue
      ArgumentError -> {:error, :not_a_number}
    end
  end

  def user_move_to_internal_state(move) do
    try do
      Map.get(
        %{
          1 => {0, 0},
          2 => {0, 1},
          3 => {0, 2},
          4 => {1, 0},
          5 => {1, 1},
          6 => {1, 2},
          7 => {2, 0},
          8 => {2, 1},
          9 => {2, 2}
        },
        move,
        {:error, :nonexistant_space}
      )
    rescue
      ArgumentError -> {:error, :nonexistant_space}
    end
  end

  def choose_mode(deps) do
    mode =
      deps.io.retrieve(deps.messages.get_message(:choose_token))
      |> deps.validation.clean()
      |> String.upcase()

    case mode do
      "1" ->
        mode

      "2" ->
        mode

      "3" ->
        mode

      _ ->
        choose_mode(deps)
    end
  end

  def space_on_board?(move) do
    cond do
      user_move_to_internal_state(move) == {:error, :nonexistant_space} ->
        {:error, :nonexistant_space}

      true ->
        {:ok, :space_on_board}
    end
  end

  def open?(move, state) do
    spot = Map.get(State.get_board(state), user_move_to_internal_state(move))

    cond do
      is_binary(spot) -> {:error, :space_taken}
      spot == move -> {:ok, :is_open}
      spot == nil -> {:error, :space_taken}
    end
  end
end

defmodule MockMessages do
  def display_message(state, _message) do
    state
  end

  def display_board(state) do
    state
  end

  def welcome do
    "welcome"
  end

  def get_message(term) do
    messages = %{
      welcome: "Welcome to Tic Tac Toe!",
      choose: "Please choose a spot by entering 1 - 9: ",
      choose_token: "Please choose your token (enter \"X\" or \"O\"): ",
      nonexistant_space: "I'm sorry, that space doesn't exist on the board, please choose again",
      space_taken: "I'm sorry, that space is taken, please choose again",
      nan: "I'm sorry, that is not a number, please enter a number",
      tie: "The game is a tie!",
      opponent_move: "Opponent's turn:"
    }

    messages[term]
  end
end

defmodule Helpers.Stack do
  use Agent

  def setup(list) do
    Agent.start_link(fn -> list end, name: __MODULE__)
  end

  def pop() do
    Agent.get_and_update(__MODULE__, fn list ->
      [h | t] = list
      {h, t}
    end)
  end

  def teardown() do
    Agent.stop(__MODULE__)
  end
end
