require 'json'

# Deals with uptading config.json
# & creating/updating the cfg files
class FilesManager
  def initialize(settings_path, settings, subreddit_name, contents)
    @settings_path = settings_path
    @settings = settings
    @subreddit_name = subreddit_name
    @contents = contents
  end

  def update
    update_json!

    return no_contents_returned if @contents.nil?

    update_cfgs!
    new_contents_returned
  end

  private

  def no_contents_returned
    puts 'No contents were returned.'
    puts "Your #{@subreddit_name}.cfg file should have the same contents as before"
    puts 'Run the script again.'
  end

  def new_contents_returned
    puts "New contents were returned, your #{@subreddit_name}.cfg file was updated."
    puts 'They might be the same contents as before, try again after a few hours if that\'s the case.'
  end

  def update_cfgs!
    @contents << 'host_writeconfig'
    setup_paths.each { |path| File.write(path, @contents.join("\n")) }
  end

  def setup_paths
    paths = @settings[@subreddit_name]['paths']
    paths.map { |path| "#{path}#{@subreddit_name}.cfg" }
  end

  def update_json!
    File.write(@settings_path, JSON.dump(@settings))
  end
end
