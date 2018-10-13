class AddsActivatedToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :activated, :integer, default: 0
  end
end
