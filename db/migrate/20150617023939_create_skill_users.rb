class CreateSkillUsers < ActiveRecord::Migration
  def change
    create_table :skill_users do |t|
      t.references :user, index: true, foreign_key: true
      t.references :skill, index: true, foreign_key: true
      t.integer :level
      t.integer :experience_year

      t.timestamps null: false
    end
  end
end
