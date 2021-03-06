module Services
  class GtfsFetcher
    # gets the mbta schedule data from a file source and saves it in assets
    include ZipUtils

    attr_reader :local_path

    def initialize(paths)
      @paths = paths
      @local_path = local_gtfs_path
      @destination_path = Pathname.getwd.to_s + "/db/neo4j/#{Rails.env}/import/" + @paths[:system_name]
    end

    def call
      current_version = current_gtfs_version
      last_version = last_gtfs_version
      if version_updated?(current_version, last_version)
        make_local_copy(source_file_path.to_s)
        unzip(local_gtfs_path, @destination_path)
        store_version
      end
      self
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
      (Rails.env == 'test' ? CSV.read(path) : CSV.parse(open(path).read))[1]
    end

    def store_version
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
