class AddStatusToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :status, :integer, default: 1
  end
end
