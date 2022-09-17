require 'unicode/emoji'

# Parses the reddit posts to be shareable on csgo
class Parser
  def initialize(settings_path, settings, subreddit_name, contents)
    @settings_path = settings_path
    @settings = settings
    @subreddit_name = subreddit_name
    @contents = contents
    @keys = @settings[@subreddit_name]['keys']
  end

  def parse
    parse_for_chat!
    [@settings_path, @settings, @subreddit_name, bind_to_keys]
  end

  private

  def parse_for_chat!
    @contents.map! do |content|
      title = parse_title(content[0])
      body = parse_body(content[1])
      [title, body]
    end
  end

  def parse_title(title)
    parsing_algorithm(title)
  end

  def parse_body(body)
    body.map { |paragraph| parsing_algorithm(paragraph) }
  end

  def parsing_algorithm(content_part)
    return content_part if content_part.length <= 255

    parsed_content_part = []
    while i = content_part.rindex(' ', 255)
      parsed_content_part << content_part[0..i]
      content_part = content_part[i + 1..]
    end
    parsed_content_part
  end

  def bind_to_keys
    return if @contents.empty?

    if @contents.flatten.length > @keys.length
      @keys.zip(@contents.flatten).map { |key, content| "bind \"#{key}\" \"say #{clean_content(content)}\"" }
    else
      @contents.flatten.zip(@keys).map { |content, key| "bind \"#{key}\" \"say #{clean_content(content)}\"" }
    end
  end

  def clean_content(content)
    content = content.gsub('"', "'")
    content.gsub(Unicode::Emoji::REGEX_WELL_FORMED, '')
  end
end
