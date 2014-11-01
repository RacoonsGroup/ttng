class CreateProjectUsers < ActiveRecord::Migration
  def change
    create_table :project_users do |t|
      t.references :project, index: true, null: false
      t.references :user, index: true, null: false

      t.timestamps
    end

    add_index :project_users, [:project_id, :user_id], unique: true
  end
end
