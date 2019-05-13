defmodule OptionsBuilderTest do
  use ExUnit.Case

  test "builds mock io wrapper" do
    assert OptionsBuilder.init() == MockTTT.IO
  end
end
