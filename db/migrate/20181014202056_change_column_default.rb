class ChangeColumnDefault < ActiveRecord::Migration[5.1]
  def change
    change_column_default :games, :player_1_turns, from: nil, to: 0
    change_column_default :games, :player_2_turns, from: nil, to: 0
    change_column_default :games, :current_turn, from: nil, to: 0
  end
end
