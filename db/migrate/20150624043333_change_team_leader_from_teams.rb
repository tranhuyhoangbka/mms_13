class ChangeTeamLeaderFromTeams < ActiveRecord::Migration
  def change
    rename_column :teams, :team_leader, :leader_id
  end
end
