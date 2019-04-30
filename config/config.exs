use Mix.Config

# dependency for Elixir's IO module
config :tic_tac_toe, :console_io, IO

config :tic_tac_toe, :deps, %{
  validation: Validation,
  messages: Messages,
  io: TTT.IO,
  human_player: HumanPlayer
}

import_config "#{Mix.env()}.exs"
