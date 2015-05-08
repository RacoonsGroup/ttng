class RemoveMiddleNameFromContacts < ActiveRecord::Migration
  def change
    remove_column :contacts, :middle_name
  end
end
