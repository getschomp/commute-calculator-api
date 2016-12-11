class GtfsFetcherJob < ApplicationJob
  queue_as :weekly

  def perform
    GtfsFetcher.new.call
  end
end
