use Mix.Config

config :tic_tac_toe, :console_io, IO

config :tic_tac_toe, :deps, %{
  io: TTT.IO
}
