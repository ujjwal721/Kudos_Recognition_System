require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

# Schedule WeeklyLeaderboardJob to run every Sunday at midnight.
scheduler.cron '* * * * *' do
  WeeklyLeaderboardJob.perform_later
end
