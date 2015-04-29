class RenameProjectInfosToComments < ActiveRecord::Migration
  def change
  	rename_table :project_infos, :comments
  end
end
