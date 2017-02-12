class AddBestsellerToProducts < ActiveRecord::Migration
  def change
    add_column :products, :bestseller, :boolean, default: false
  end
end
