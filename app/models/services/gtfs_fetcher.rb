module Services
  class GtfsFetcher
    # gets the mbta schedule data from a file source and saves it in assets
    attr_reader :local_path

    def initialize(paths)
      @paths = paths
      @local_path = local_gtfs_path
    end

    def call
      current_version = current_gtfs_version
      last_version = last_gtfs_version
      if version_updated?(current_version, last_version)
        make_local_copy(source_file_path.to_s)
        store_version(current_version)
      end
      self
    end

    # For now this is a class method initalized based of the @paths to MBTA data.
    # Since the GTFS spec is the same for most major cities,
    # In the future, many Gtfs Fetchers may be initalized with various
    # @paths based on a json file or similar
    # TODO: see if there is a source api to call that has an index of paths
    def self.run_for_mbta
      self.new({
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
      }).run
    end


    private

    def make_local_copy(source_path)
      File.new(@local_path, "w")
      IO.copy_stream(open(source_path), @local_path)
    end

    def version_updated?(current_version, last_version)
      current_version != last_version
    end

    def current_gtfs_version
      get_version(feed_info_path.to_s)
    end

    def last_gtfs_version
      make_version_file_if_needed
      get_version(version_path)
    end

    def get_version(path)
      CSV.read(path)[1]
    end

    def store_version(version)
      make_version_file_if_needed
      IO.copy_stream(open(feed_info_path), version_path)
    end

    def make_version_file_if_needed
      Dir.mkdir(@paths[:local][:root]) unless File.exist?(@paths[:local][:root])
      File.new(version_path, "w+") unless File.exist?(version_path)
    end

    def feed_info_path
      full_path(@paths[:source][:root], @paths[:source][:feed_info_suffix])
    end

    def version_path
      full_path(@paths[:local][:root], @paths[:local][:version_suffix])
    end

    def source_file_path
      full_path(@paths[:source][:root], @paths[:source][:gtfs_suffix])
    end

    def local_gtfs_path
      full_path(@paths[:local][:root], @paths[:local][:gtfs_suffix])
    end

    def full_path(root, suffix)
      Pathname.new(root + suffix)
    end
  end
end
