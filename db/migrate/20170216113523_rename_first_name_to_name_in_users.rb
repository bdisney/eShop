class RenameFirstNameToNameInUsers < ActiveRecord::Migration
  def change
    def up
      rename_column :users, :first_name, :name
    end

    def down
      rename_column :users, :name, :first_name
    end
  end
end
