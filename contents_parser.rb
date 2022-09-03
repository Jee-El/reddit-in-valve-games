require 'unicode/emoji'

class ContentsParser
  def initialize(settings, subreddit_name, contents)
    @settings = settings
    @subreddit_name = subreddit_name
    @contents = contents
    @keys = @settings[@subreddit_name]['keys']
  end

  def parse
    parse_for_chat!
    [@settings, @subreddit_name, bind_to_keys]
  end

  private

  def parse_for_chat!
    @contents.map! do |content|
      content.map do |content_part|
        # content_part is either the title or the body
        content_part = content_part.split(' ')
        parsed_content = ['']
        i = 0
        j = 0
        loop do
          if (parsed_content[i] + " " + content_part[j]).length <= 255
            parsed_content[i] << " " << content_part[j]
            j += 1
          else
            i += 1
            parsed_content[i] = ''
          end
          break if j == content_part.length
        end
        parsed_content
      end
    end
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