class AddIndexToLeaderboardScoreOnUsers < ActiveRecord::Migration[8.0]
  def change
    add_index :users, :leaderboard_score
  end
end
