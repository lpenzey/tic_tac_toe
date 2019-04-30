defmodule TicTacToe do
  def main(_opts \\ []) do
    deps = OptionsBuilder.init()
    deps.messages.welcome()
    state = Game.init(deps.player.choose_token(deps))
    Game.play(state, deps)
  end
end
