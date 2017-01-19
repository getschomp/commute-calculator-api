require 'rails_helper'

RSpec.describe Services::GtfsFetcher, type: :service do

  describe '#call' do

    before :each do
      FileUtils.rm_rf Dir.glob("spec/support/temp/*")
      FileUtils.rm_rf Dir.glob( "/db/neo4j/#{Rails.env}/import/boston_test")
      @common_paths = {
        system_name: 'boston_test',
        source: {
          root: Rails.root.join('spec/support/fixtures/'),
          gtfs_suffix: 'mbta.zip',
          feed_info_suffix: 'feed_info.txt'
        }
      }
    end

    context 'first run' do
      before :each do
        paths = @common_paths.merge(
          local: {
            root: Rails.root.join('spec/support/temp/'),
            gtfs_suffix: 'mbta.zip',
            version_suffix: 'version.csv'
          }
        )
        @fetcher = Services::GtfsFetcher.new(paths).call
      end

      it 'fetches the correct local path' do
        expect(@fetcher.local_path.to_s).to include('spec/support/temp/mbta.zip')
      end

      it 'fetches a new file' do
        file_path = @fetcher.local_path.to_s
        expect(File.exist?(file_path)).to be true
      end
    end

    context 'No new versions' do
      before :each do
        paths = @common_paths.merge({
          local: {
            root: Rails.root.join('spec/support/fixtures/'),
            gtfs_suffix: 'file_that_shouldnt_exist.zip',
            version_suffix: 'feed_info.txt'
          }
        })
        @fetcher = Services::GtfsFetcher.new(paths).call
      end

      it 'does not fetch a new file' do
        file_path = Rails.root + @fetcher.local_path.to_s
        expect(File.exist?(file_path)).to be false
      end
    end

  end
end
