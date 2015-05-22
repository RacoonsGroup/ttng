class AddColumnsToCustomers < ActiveRecord::Migration
  def change
  	add_column :customers, :subject, :integer
  	add_column :customers, :profile, :integer
  	add_column :customers, :source, :string
  	add_column :customers, :describe, :text
  	add_column :customers, :url, :string
  end
end
