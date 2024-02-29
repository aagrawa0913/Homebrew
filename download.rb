require 'open-uri'
require 'fileutils'

# Function to download a tar.gz file from a URL and store it in a specified folder
def download_tar_gz(url, destination_folder)
  # Create the destination folder if it doesn't exist
  FileUtils.mkdir_p(destination_folder) unless Dir.exist?(destination_folder)

  # Extract the file name from the URL
  file_name = File.basename(url)

  # Combine the destination folder path with the file name
  destination_file = File.join(destination_folder, file_name)

  puts "Downloading file from #{url} to #{destination_file}..."

  # Download the file from the URL and store it in the destination folder
  open(destination_file, 'wb') do |file|
    file << URI.open(url).read
  end

  puts "File downloaded successfully to: #{destination_file}"
rescue StandardError => e
  puts "Error downloading file: #{e.message}"
end
    
# Function to extract a tar.gz file
def extract_tar_gz(tar_gz_file, destination_folder)
  # Execute the tar command to extract the tar.gz file to the destination folder
  system("tar -xzf #{tar_gz_file} -C #{destination_folder}")
end

# Example usage
download_tar_gz("https://tools.veracode.com/veracode-cli/veracode-cli_2.9.3_macosx_arm64.tar.gz", "/usr/local/bin/")

#url = "https://tools.veracode.com/veracode-cli/LATEST_VERSION"
#text = read_text_from_url(url)

# Example usage
#tar_gz_file = "/usr/local/bin/veracode-cli_2.9.3_macosx_arm64.tar.gz"
#destination_folder = "/usr/local/bin/"

#extract_tar_gz(tar_gz_file, destination_folder)