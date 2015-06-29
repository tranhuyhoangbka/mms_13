class CreatePositionUsers < ActiveRecord::Migration
  def change
    create_table :position_users do |t|
      t.references :position, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
