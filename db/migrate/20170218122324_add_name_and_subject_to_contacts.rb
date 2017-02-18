class AddNameAndSubjectToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :name, :string
    add_column :contacts, :subject, :string
  end
end
