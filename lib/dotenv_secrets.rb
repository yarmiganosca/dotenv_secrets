require "dotenv_secrets/version"

class DotenvSecrets  
  def initialize(path:)
    @path = path
  end

  def [](key)
    # We only want to keep the file contents in memory
    # until the next GC, so we don't store the lines in
    # an instance variable.
    key_line = Pathname.new(path).each_line.find do |line|
      line.start_with?("#{key}=")
    end

    if key_line
      key_line[(key.size + 1)..-1].chomp
    else
      raise KeyError, "key #{key} not found in #{path}"
    end
  end

  private

  attr_reader :path
end
