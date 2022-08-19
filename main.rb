require 'open-uri'
require 'nokogiri'
require 'json'

class Scraper
  def initialize
    unparsed_json = File.read('./config.json')
    @parsed_json = JSON.parse(unparsed_json)

    @subreddit_name = @parsed_json['currently_used_subreddit_name']
    @subreddit_url = @parsed_json[@subreddit_name]['url']

    if @parsed_json[@subreddit_name]['has_to_reset_time']
      @parsed_json[@subreddit_name]['call_date'] = Time.new
      @parsed_json[@subreddit_name]['has_to_reset_time'] = false
    end

    @total_requests = @parsed_json[@subreddit_name]['total_requests']
    @maximum_requests = @parsed_json[@subreddit_name]['maximum_requests']
    @keys = @parsed_json[@subreddit_name]['keys']
    @attempts = 0
    @contents = []
  end

  def start
    scrape
    update_requests
    parse_for_chat!
    @contents = bind_to_keys
    update_cfgs!
    File.write('./config.json', JSON.dump(@parsed_json))
  end

  private

  def scrape
    while @attempts < 5 && @total_requests < @maximum_requests && @contents.empty?
      begin
        unparsed_page = URI.open(@subreddit_url)
        parsed_page = Nokogiri::HTML(unparsed_page)
        all_posts = parsed_page.css('.rpBJOHq2PR60pnwJlUyP0 > div')
        all_posts.each_with_index do |post, index|
          next if index < 3

          post = post.children[0].children[0].children[2].children
          title = post[1]
          4.times { title = title.children[0] }
          body = post[2]
          4.times { body = body.children[0] }
          @contents << [title.text, body.text]
        end
      rescue NoMethodError
        sleep 2
        @attempts += 1
        retry if @attempts < 5
      end
      @attempts += 1
    end
  end

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
    if @contents.flatten.length > @keys.length
      @keys.zip(@contents.flatten).map { |key, joke| "bind \"#{key}\" \"say #{joke}\"" }
    else
      @contents.flatten.zip(@keys).map { |joke, key| "bind \"#{key}\" \"say #{joke}\"" }
    end
  end

  def update_requests
    @parsed_json[@subreddit_name]['total_requests'] += @attempts
    reset_requests if reset_requests?
  end

  def reset_requests?
    # 86_400 is a day in seconds
    Time.new - Time.parse(@parsed_json[@subreddit_name]['call_date'].to_s) >= 86_400
  end

  def reset_requests
    @parsed_json[@subreddit_name]['total_requests'] = 0
    @parsed_json[@subreddit_name]['has_to_reset_time'] = true
  end

  def update_cfgs!
    if @contents.empty?
      puts 'No jokes were returned so try again. Your .cfg file should have the same jokes as before'
      return
    end
    @parsed_json[@subreddit_name]['cfgs'].each { |cfg| File.write(cfg, (@contents + ['host_writeconfig']).join("\n")) }
    puts 'New jokes were returned, your .cfg file was updated.'
    puts 'They might be the same jokes as before, try again after a few hours if that\'s the case'
  end
end

Scraper.new.start