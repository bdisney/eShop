class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.email :email
      t.text :message

      t.timestamps null: false
    end
  end
end
