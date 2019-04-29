ExUnit.start()

defmodule MockHumanPlayer do
  def choose_token(_deps) do
    "X"
  end
end

defmodule MockInput do
  def retrieve(message) do
    gets(message)
  end

  def gets(_prompt) do
    Helpers.Stack.pop()
  end

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
end

defmodule MockOutput do
  def display_message(state, _message) do
    state
  end

  def display_board(state) do
    state
  end

  def welcome do
    "welcome"
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
