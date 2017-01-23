class AddSubTitleToNews < ActiveRecord::Migration
  def change
    add_column :news, :sub_title, :string
  end
end
