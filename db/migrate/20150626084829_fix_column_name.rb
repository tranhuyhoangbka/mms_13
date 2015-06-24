class FixColumnName < ActiveRecord::Migration
  def self.up
    rename_column :projects, :project_manager, :leader_id
  end
end
