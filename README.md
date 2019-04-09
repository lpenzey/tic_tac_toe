# TicTacToe
A simple implementation of Tic Tac Toe, aka Noughts and Crosses, in the Command Line. 

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `tic_tac_toe` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:tic_tac_toe, "~> 0.1.0"}
  ]
end
```

Otherwise, download this repository with the "clone or download" button at the top of this page. 

This project was built in Elixir and uses [mix](https://hexdocs.pm/mix/Mix.html#content) to start the game and run the accompanying test suite. To run this application you'll first need to install Elixir (which comes with mix) from this page [here](https://elixir-lang.org/install.html). Once installed you can run the commands detailed below from the project's root directory. 

## Testing
Navigate to this project's directory and run the following mix command:
```mix test```

## Starting the Game
In the project's root directory, run the following mix command to start the game:
```mix run -e 'TicTacToe.main()'```
