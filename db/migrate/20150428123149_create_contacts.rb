class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.references :customer, index: true
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :mobile
      t.string :skype
      t.string :email
      t.text :describe

      t.timestamps null: false
    end
    add_foreign_key :contacts, :customers
  end
end
