class LeaderboardController < ApplicationController
    before_action :authenticate_user!
  
    def index
      @top_users = Rails.cache.fetch("top_leaderboard", expires_in: 10.minutes) do
        User.order(leaderboard_score: :desc).limit(10).to_a
      end
    end
  end
  