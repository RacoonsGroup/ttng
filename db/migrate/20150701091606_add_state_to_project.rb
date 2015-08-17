class AddStateToProject < ActiveRecord::Migration
  def change
    add_column :projects, :state, :integer, default: 0
  end
end
