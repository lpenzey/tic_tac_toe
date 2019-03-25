defmodule Board do
  def gen_values(state) do
    State.get_board(state)
    |> Map.values()
  end

  def build(state) do
    moves = gen_values(state)

    square = %{
      :top_left => "┌",
      :bottom_left => "└",
      :bottom_right => "┘",
      :top_right => "┐",
      :span => "─",
      :upright => "│",
      :top_middle => "┬",
      :left_middle => "├",
      :right_middle => "┤",
      :bottom_middle => "┴",
      :center => "┼"
    }

    row1 =
      "#{square[:top_left]}#{square[:span]}#{square[:span]}#{square[:span]}#{square[:top_middle]}#{
        square[:span]
      }#{square[:span]}#{square[:span]}#{square[:top_middle]}#{square[:span]}#{square[:span]}#{
        square[:span]
      }#{square[:top_right]}\n"

    row2 =
      "#{square[:upright]} #{Enum.at(moves, 0)} #{square[:upright]} #{Enum.at(moves, 1)} #{
        square[:upright]
      } #{Enum.at(moves, 2)} #{square[:upright]}\n"

    row3 =
      "#{square[:left_middle]}#{square[:span]}#{square[:span]}#{square[:span]}#{square[:center]}#{
        square[:span]
      }#{square[:span]}#{square[:span]}#{square[:center]}#{square[:span]}#{square[:span]}#{
        square[:span]
      }#{square[:right_middle]}\n"

    row4 =
      "#{square[:upright]} #{Enum.at(moves, 3)} #{square[:upright]} #{Enum.at(moves, 4)} #{
        square[:upright]
      } #{Enum.at(moves, 5)} #{square[:upright]}\n"

    row5 =
      "#{square[:left_middle]}#{square[:span]}#{square[:span]}#{square[:span]}#{square[:center]}#{
        square[:span]
      }#{square[:span]}#{square[:span]}#{square[:center]}#{square[:span]}#{square[:span]}#{
        square[:span]
      }#{square[:right_middle]}\n"

    row6 =
      "#{square[:upright]} #{Enum.at(moves, 6)} #{square[:upright]} #{Enum.at(moves, 7)} #{
        square[:upright]
      } #{Enum.at(moves, 8)} #{square[:upright]}\n"

    row7 =
      "#{square[:bottom_left]}#{square[:span]}#{square[:span]}#{square[:span]}#{
        square[:bottom_middle]
      }#{square[:span]}#{square[:span]}#{square[:span]}#{square[:bottom_middle]}#{square[:span]}#{
        square[:span]
      }#{square[:span]}#{square[:bottom_right]}"

    ~s(#{row1}#{row2}#{row3}#{row4}#{row5}#{row6}#{row7})
  end
end
