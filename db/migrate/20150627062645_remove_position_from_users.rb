class RemovePositionFromUsers < ActiveRecord::Migration
  def change
    remove_reference :users, :position, index: true, foreign_key: true
  end
end
