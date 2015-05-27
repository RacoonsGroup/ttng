class AddUserIdToAttaches < ActiveRecord::Migration
  def change
    add_column :attaches, :user_id, :integer
  end
end
