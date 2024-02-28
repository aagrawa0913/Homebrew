class VeracodeCli < Formula
    desc "Veracode CLI"
    homepage "https://www.veracode.com/"
    url "https://tools.veracode.com/veracode-cli/LATEST_VERSION"
    version "2.9.3"
    sha256 "490b9206568315aae82981a2889ccdefbee435c9174af904377bd08afe394113"
  
    def install
      # Download and extract the tar.gz file
      tar_gz_file = "#{staged_path}/veracode-cli_#{version}_macosx_arm64.tar.gz"
      destination_folder = "#{libexec}/veracode-cli_#{version}_macosx_arm64/"
      FileUtils.mkdir_p(destination_folder)
  
      puts "Downloading file from #{url} to #{tar_gz_file}..."
      curl_download url, to: tar_gz_file
  
      ohai "Extracting file from #{tar_gz_file} to #{destination_folder}..."
      safe_system "tar", "-xzf", tar_gz_file, "-C", destination_folder
      ohai "Extraction successful to #{destination_folder}..."
  
      # Install Veracode CLI binary
      bin.install_symlink "#{destination_folder}/veracode"
    end
  
    test do
      system "#{bin}/veracode", "--version"
    end
  end
  