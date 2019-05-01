defmodule TicTacToe do
  def main(_opts \\ []) do
    deps = OptionsBuilder.init()
    deps.messages.welcome()
    mode = Game.select_mode(deps.validation.choose_mode(deps))
    state = Game.init(deps.player.choose_token(deps))
    Game.play(state, deps, mode)
  end
end
