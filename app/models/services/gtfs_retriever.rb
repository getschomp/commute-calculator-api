require 'pathname'
require 'csv'
require 'open-uri'
require 'uri'

class GtfsFetcher
  # gets the mbta schedule data from a file source and saves it in assets

  attr_reader :local_path

  # For now this is a constant based of the paths to MBTA data.
  # Since the GTFS spec is the same for most major cities,
  # In the future, many Gtfs Retrievers may be initalized with various
  # @paths instance variables.
  PATHS = {
    source: {
      root: 'http://www.mbta.com/uploadedfiles/',
      gtfs_suffix: 'MBTA_GTFS.zip',
      feed_info_suffix: 'feed_info.txt'
    },
    local: {
      root: Pathname.getwd.to_s + "/assets/data/",
      gtfs_suffix: 'mbta.zip',
      version_suffix: 'version.csv'
    }
  }.freeze

  def call
    @current_version = current_gtfs_version
    @last_version = last_gtfs_version
    @local_path = local_gtfs_path
    if version_updated?
      make_local_copy(source_file_path.to_s)
      store_version(@current_version)
    end
    self
  end

  private

  def make_local_copy(source_path)
    File.new(@local_path, "w")
    IO.copy_stream(open(source_path), @local_path)
  end

  def version_updated?
    @first_version != @last_version
  end

  def current_gtfs_version
    feed = CSV.new(open(feed_info_path.to_s), headers: :first_row)
    feed.each { |row| return row[5] }
  end

  def last_gtfs_version
    File.new(version_path, "w+") if !version_path.exist?
    IO.read(version_path)
  end

  def store_version(version)
    File.open(version_path, 'w') { |f| f.write(version) }
  end

  def feed_info_path
    full_path(PATHS[:source][:root], PATHS[:source][:feed_info_suffix])
  end

  def version_path
    full_path(PATHS[:local][:root], PATHS[:local][:version_suffix])
  end

  def source_file_path
    full_path(PATHS[:source][:root], PATHS[:source][:gtfs_suffix])
  end

  def local_gtfs_path
    full_path(PATHS[:local][:root], PATHS[:local][:gtfs_suffix])
  end

  def full_path(root, suffix)
    Pathname.new(root + suffix)
  end

end
