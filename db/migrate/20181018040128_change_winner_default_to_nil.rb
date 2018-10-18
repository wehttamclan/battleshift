class ChangeWinnerDefaultToNil < ActiveRecord::Migration[5.1]
  def change
    change_column_default :games, :winner, from: "", to: nil
  end
end
