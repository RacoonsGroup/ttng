class AddColumnsToCustomers < ActiveRecord::Migration
  def change
  	add_column :customers, :subject, :integer, null: false
  	add_column :customers, :type, :integer, null: false
  	add_column :customers, :source, :string, null: false
  	add_column :customers, :describe, :text
  end
end
