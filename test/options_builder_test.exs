defmodule OptionsBuilderTest do
  use ExUnit.Case

  test "builds test dependencies" do
    assert OptionsBuilder.init() == %{
             validation: MockValidation,
             messages: MockMessages,
             io: MockTTT.IO,
             human_player: MockHumanPlayer
           }
  end
end
