class ChangeActivities < ActiveRecord::Migration
  def change
    remove_column :activities, :time
    add_column :activities, :object, :string
  end
end
