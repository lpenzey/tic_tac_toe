ExUnit.start()

defmodule MockTTT.IO do
  def retrieve(message) do
    gets(message)
  end

  def gets(_prompt) do
    Helpers.Stack.pop()
  end

  def display(message) do
    puts(message)
  end

  def puts(message) do
    message
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
