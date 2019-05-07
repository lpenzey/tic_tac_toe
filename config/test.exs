use Mix.Config

config :tic_tac_toe, :console_io, MockTTT.IO

config :tic_tac_toe, :deps, %{
  io: MockTTT.IO
}
