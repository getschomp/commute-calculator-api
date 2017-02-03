module ZipUtils
  require 'zip'
  require 'fileutils'



  def unzip(file_source_path, destination_path)
    unless File.directory?(destination_path)
      FileUtils.mkdir_p(destination_path)
    end

    Zip::File.open(file_source_path) do |zip_file|
      zip_file.each do |entry|
        new_file_path = destination_path + '/' + entry.name
        puts "Extracting #{entry.name}"
        entry.extract(new_file_path) unless File.exist?(new_file_path)
      end
    end
  end
end
