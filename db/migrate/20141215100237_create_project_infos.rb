class CreateProjectInfos < ActiveRecord::Migration
  def change
    create_table :project_infos do |t|
      t.references :project, index: true, null: false
      t.string :title, null: false
      t.text :info, null: false
      t.boolean :encrypted, null: false, default: false
      t.timestamps
    end
  end
end
