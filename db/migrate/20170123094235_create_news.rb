class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :title
      t.text :body
      t.string :image_url


      t.timestamps null: false
    end
  end
end
