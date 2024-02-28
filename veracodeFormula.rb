require 'open-uri'
require 'digest'
require 'digest'

class VeracodeFormula < Formula
  desc "My Homebrew Formula"
  homepage "https://example.com"
  version "2.9.3"

  # Define the URL for the formula
  url "https://tools.veracode.com/veracode-cli/LATEST_VERSION"

  # Define the SHA256 checksum dynamically
  sha256 generate_sha256(url)


# Function to read version from a webpage loaded from a URL
def read_text_from_url(url)
    begin
      # Open the URL and read its content
      content = URI.open(url, &:read)
      process_text(content)
      return content
    rescue => e
      puts "Error: #{e.message}"
      return nil
    end
  end
  
  # Function to process text
  def process_text(text)
    # Process the text here if needed
    if text
      modified_text = "https://tools.veracode.com/veracode-cli/veracode-cli_" + text + "_macosx_arm64.tar.gz"
      download_tar_gz(modified_text, "/usr/local/bin/")
      sha256_hash = generate_sha256(modified_text)
      print_text(sha256_hash)
    else
      puts "Failed to Process version from #{url}"
    end
  end
  
  # Function to generate SHA256 hash
  def generate_sha256(text)
    Digest::SHA256.hexdigest(text)
  end
  
  # Function to print text
  def print_text(text)
    # Process the text here if needed
    puts "Text received sha256 :"
    puts text
  end

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
  puts "Extracting file from #{tar_gz_file} to #{destination_folder}..."
  system("tar -xzf #{tar_gz_file} -C #{destination_folder}")
  puts "Extraction Successfull to #{destination_folder}..."
end

# Function to remove a tar.gz file from bin folder after Extraction
def remove_tar_gz_file(folder, file_name)
    tar_gz_file = File.join(folder, file_name)
  
    if File.exist?(tar_gz_file)
      FileUtils.rm(tar_gz_file)
      puts "Removed #{tar_gz_file}"
    else
      puts "File #{tar_gz_file} does not exist"
    end
  end

# Define a method to execute the install.sh script
def execute_install_script(folder_path)
  # Give execute permission to the folder and the install.sh script
  FileUtils.chmod("u+x", folder_path)
  FileUtils.chmod("u+x", File.join(folder_path, "install.sh"))

  # Execute the install.sh script
  success = system("cd #{folder_path} && ./install.sh")

  # Check if the execution was successful
  if success
    puts "Installation script executed successfully"
  else
    puts "Failed to execute installation script"
  end
end

# Example usage to read the version of the file to be downloaded
url = "https://tools.veracode.com/veracode-cli/LATEST_VERSION"
text = read_text_from_url(url)

# Example usage Extraction of the downloaded tar.gz file
tar_gz_file = "/usr/local/bin/veracode-cli_"+text+"_macosx_arm64.tar.gz"
destination_folder = "/usr/local/bin/"
extract_tar_gz(tar_gz_file, destination_folder)

# Example usage Removal of tar.gz file after extraction is done
folder = "/usr/local/bin/"
file_name = "veracode-cli_"+text+"_macosx_arm64.tar.gz"
remove_tar_gz_file(folder, file_name)

# Example usage Installing Veracode
folder_path = "/usr/local/bin/veracode-cli_"+text+"_macosx_arm64/"
execute_install_script(folder_path)



