module Services
  class GtfsFetchRunner
    # In the future, many Gtfs Fetchers may be initalized with various
    # @paths based on a json file or similar
    # TODO: see if there is a source api to call that has an index of paths
    BOSTON_PATHS = {
      system_name: 'boston',
      source: {
        root: 'http://www.mbta.com/uploadedfiles/',
        gtfs_suffix: 'MBTA_GTFS.zip',
        feed_info_suffix: 'feed_info.txt'
      },
      local: {
        root: Pathname.getwd.to_s + "/db/csvs/",
        gtfs_suffix: 'mbta.zip',
        version_suffix: 'version.csv'
      }
    }.freeze

    def call
      fetcher_collection = []
      [BOSTON_PATHS].each do |paths|
        fetcher = GtfsFetcher.new(paths).call
        fetcher_collection << fetcher
      end
      fetcher_collection
    end

  end
end
