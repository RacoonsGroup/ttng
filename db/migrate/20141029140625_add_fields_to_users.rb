class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string, null: false, default: ''
    add_column :users, :last_name, :string, null: false, default: ''
    add_column :users, :birth_date, :date, null: false, default: Date.today


    add_column :users, :position, :integer, null: false, default: 0
    add_column :users, :hire_date, :date, null: false, default: Date.today
    add_column :users, :fire_date, :date
    add_column :users, :salary_kopeks, :integer, null: false, default: 0
    add_column :users, :official_salary_kopeks, :integer, null: false, default: 0
    add_column :users, :inn, :string
    add_column :users, :snils, :string
  end
end
