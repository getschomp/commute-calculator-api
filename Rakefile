# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

desc 'Get the latest gtfs files if a new version exists'
task fetch_gtfs: :environment do
  Services::GtfsFetcher.new.run
end
