class ChangeWinnerInGamesToString < ActiveRecord::Migration[5.1]
  def change
    change_column :games, :winner, :string, default: ""
  end
end
