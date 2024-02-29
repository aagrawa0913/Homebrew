require 'open-uri'

# Function to read text from a webpage loaded from a URL
def read_text_from_url(url)
  begin
    # Open the URL and read its content
    content = URI.open(url, &:read)

    return content
  rescue => e
    puts "Error: #{e.message}"
    return nil
  end
end

# Example usage
def main
  url = "https://tools.veracode.com/veracode-cli/LATEST_VERSION"
  text = read_text_from_url(url)
    # Process the text here if needed
    if text
      modified_text = "https://tools.veracode.com/veracode-cli/veracode-cli_" + text + "_macosx_arm64.tar.gz"
      return modified_text
    else
      puts "Failed to Process version from #{url}"
    end
  end

# Call the main function
main if __FILE__ == $0
