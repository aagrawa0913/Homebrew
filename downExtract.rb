require 'open-uri'
require 'digest'

# Function to read version from a webpage loaded from a URL
def read_text_from_url(url)
  begin
    # Open the URL and read its content
    content = URI.open(url, &:read)
    #process_text(content)
    return content
  rescue => e
    puts "Error: #{e.message}"
    return nil
  end
end

# Function to extract a tar.gz file
def extract_tar_gz(tar_gz_file, destination_folder)
  # Execute the tar command to extract the tar.gz file to the destination folder
  system("tar -xzf #{tar_gz_file} -C #{destination_folder}")
end

# Example usage
url = "https://tools.veracode.com/veracode-cli/LATEST_VERSION"
text = read_text_from_url(url)
puts "Text from #{url}: #{text}"


tar_gz_file = "/usr/local/bin/veracode-cli_"+text+"_macosx_arm64.tar.gz"
puts tar_gz_file
destination_folder = "/usr/local/bin/"

extract_tar_gz(tar_gz_file, destination_folder)