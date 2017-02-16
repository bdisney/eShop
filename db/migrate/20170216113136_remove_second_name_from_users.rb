class RemoveSecondNameFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :second_name, :string
  end
end
