use Mix.Config

config :tic_tac_toe, :deps, %{
  input: MockInput,
  output: MockOutput,
  validity: Validity,
  human_player: MockHumanPlayer
}
