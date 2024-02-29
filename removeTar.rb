require 'fileutils'

# Function to remove a tar.gz file from a folder
def remove_tar_gz_file(folder, file_name)
  tar_gz_file = File.join(folder, file_name)

  if File.exist?(tar_gz_file)
    FileUtils.rm(tar_gz_file)
    puts "Removed #{tar_gz_file}"
  else
    puts "File #{tar_gz_file} does not exist"
  end
end

# Example usage
folder = "/usr/local/bin/"
file_name = "veracode-cli_2.9.3_macosx_arm64.tar.gz"

remove_tar_gz_file(folder, file_name)
