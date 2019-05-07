defmodule OptionsBuilderTest do
  use ExUnit.Case

  test "builds test dependencies" do
    assert OptionsBuilder.init() == %{
             io: MockTTT.IO
           }
  end
end
