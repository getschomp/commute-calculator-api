require 'rails_helper'

RSpec.describe Services::GtfsFetcher, type: :service do

  describe '#call' do

    before :each do
      FileUtils.rm_rf Dir.glob("spec/support/temp/*")
      @fetcher = Services::GtfsFetcher.new({
        source: {
          root: 'spec/support/fixtures/',
          gtfs_suffix: 'mbta.zip',
          feed_info_suffix: 'feed_info.txt'
        },
        local: {
          root: 'spec/support/temp/',
          gtfs_suffix: 'mbta.zip',
          version_suffix: 'version.csv'
        }
      }).call
    end

    it 'gets the correct local path' do
      expect(@fetcher.local_path.to_s).to eq('spec/support/temp/mbta.zip')
    end

    it 'gets a new file' do
      file_name = @fetcher.local_path.to_s
      expect { File.open(file_name) { } }.to_not raise_error
    end
  end
end
