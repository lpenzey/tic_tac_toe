use Mix.Config

config :tic_tac_toe, :deps, %{
  validation: MockValidation,
  messages: MockMessages,
  io: MockTTT.IO,
  player: Player
}
