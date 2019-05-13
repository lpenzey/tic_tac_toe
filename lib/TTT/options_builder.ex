defmodule OptionsBuilder do
  def init() do
    build_deps()
  end

  def build_deps() do
    Application.get_env(:tic_tac_toe, :io_wrapper)
  end
end
