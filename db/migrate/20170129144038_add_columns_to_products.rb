class AddColumnsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :main_category_id, :integer
  end
end
