use Mix.Config

config :tic_tac_toe, :deps, %{
  validation: Validation,
  messages: Messages,
  io: TTT.IO,
  human_player: HumanPlayer
}
