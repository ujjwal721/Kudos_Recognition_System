class WeeklyLeaderboardJob < ApplicationJob
  queue_as :default

  def perform(*args)
    User.find_each do |user|
      total_points = user.kudos_received.sum(:points)
      user.update(leaderboard_score: total_points)
    end
  end
end
