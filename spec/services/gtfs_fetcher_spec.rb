require 'rails_helper'

RSpec.describe Services::GtfsFetcher, type: :service do

  describe '#call' do

    before :each do
      FileUtils.rm_rf Dir.glob("spec/support/temp/*")
    end

    context 'first run' do
      before :each do
        @fetcher = Services::GtfsFetcher.new({
          source: {
            root: Rails.root.join('spec/support/fixtures/'),
            gtfs_suffix: 'mbta.zip',
            feed_info_suffix: 'feed_info.txt'
          },
          local: {
            root: Rails.root.join('spec/support/temp/'),
            gtfs_suffix: 'mbta.zip',
            version_suffix: 'version.csv'
          }
        }).call
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
        @fetcher = Services::GtfsFetcher.new({
          source: {
            root: Rails.root.join('spec/support/fixtures/'),
            gtfs_suffix: 'mbta.zip',
            feed_info_suffix: 'feed_info.txt'
          },
          local: {
            root: Rails.root.join('spec/support/fixtures/'),
            gtfs_suffix: 'file_that_shouldnt_exist.zip',
            version_suffix: 'feed_info.txt'
          }
        }).call
      end

      it 'does not fetches a new file' do
        file_path = Rails.root + @fetcher.local_path.to_s
        expect(File.exist?(file_path)).to be false
      end
    end

  end
end
