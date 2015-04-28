class AddFormToComments < ActiveRecord::Migration
  def change
    add_column :comments, :form, :integer, default: 0
  end
end
