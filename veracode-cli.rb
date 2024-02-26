cask 'veracode-cli' do
    version '2.9.3'
    sha256 '490b9206568315aae82981a2889ccdefbee435c9174af904377bd08afe394113'
  
    url "https://tools.veracode.com/veracode-cli/veracode-cli_#{version}_macosx_arm64.tar.gz"
    name 'Veracode CLI'
    homepage 'https://www.veracode.com/'
  
    binary 'veracode-cli'
  
    preflight do
      # Function to extract a tar.gz file
      tar_gz_file = "#{staged_path}/veracode-cli_#{version}_macosx_arm64.tar.gz"
      destination_folder = "/usr/local/bin/"
  
      # Execute the tar command to extract the tar.gz file to the destination folder
      ohai "Extracting file from #{tar_gz_file} to #{destination_folder}..."
      system("tar -xzf #{tar_gz_file} -C #{destination_folder}")
      ohai "Extraction Successful to #{destination_folder}..."
    end
  
    uninstall_postflight do
      # Example usage Removal of tar.gz file after extraction is done
      folder = "/usr/local/bin/"
      file_name = "veracode-cli_#{version}_macosx_arm64.tar.gz"
  
      tar_gz_file = File.join(folder, file_name)
  
      if File.exist?(tar_gz_file)
        FileUtils.rm(tar_gz_file)
        ohai "Removed #{tar_gz_file}"
      else
        ohai "File #{tar_gz_file} does not exist"
      end
    end
  end
  