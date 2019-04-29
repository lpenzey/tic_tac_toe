defmodule OptionsBuilderTest do
  use ExUnit.Case

  test "builds test dependencies" do
    assert OptionsBuilder.init() == %{
             human_player: MockHumanPlayer,
             input: MockInput,
             output: MockOutput,
             validity: Validity
           }
  end
end
