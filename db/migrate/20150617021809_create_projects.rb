class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :abbreviation
      t.date :start_date
      t.date :end_date
      t.references :team, index: true, foreign_key: true
      t.integer :project_manager

      t.timestamps null: false
    end
  end
end
