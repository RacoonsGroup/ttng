class AddPivotalIdToProject < ActiveRecord::Migration
  def change
    add_column :projects, :pivotal_id, :integer
  end
end
