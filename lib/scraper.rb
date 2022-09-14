require 'open-uri'
require 'nokogiri'
require 'json'

class Scraper
  def initialize
    unparsed_settings = File.read(settings_path)
    @settings = JSON.parse(unparsed_settings)

    @subreddit_name = @settings['currently_used_subreddit_name']
    @subreddit_url = @settings[@subreddit_name]['url']
    @settings[@subreddit_name]['call_date'] ||= Time.new.to_s
    @total_requests = @settings[@subreddit_name]['total_requests']
    @maximum_requests = @settings[@subreddit_name]['maximum_requests']
    @attempts = 0
    @contents = []

    reset_requests && reset_call_date if reset_requests?
  end

  def start
    scrape
    update_requests
    [settings_path, @settings, @subreddit_name, p(@contents)]
  end

  private

  def settings_path
    cloned_repo_possible_paths = `bash -c "find ~ -type d -name 'reddit-in-valve-games' 2> /dev/null"`.split("\n")
    cloned_repo_path = cloned_repo_possible_paths.find do |cloned_repo_possible_path|
      !cloned_repo_possible_path.include?('.config')
    end
    "#{cloned_repo_path}/config.json"
  end

  def scrape
    while @attempts < 5 && @total_requests < @maximum_requests && @contents.empty?
      begin
        unparsed_page = URI.parse(@subreddit_url).open
        parsed_page = Nokogiri::HTML(unparsed_page)
        all_posts = parsed_page.css('.rpBJOHq2PR60pnwJlUyP0 > div')
        all_posts.each_with_index do |post, index|
          next if index < 3

          post = post.children[0].children[0].children[2].children
          title = post[1]
          4.times { title = title.children[0] }
          body = post[2]
          3.times { body = body.children[0] }
          body = body.children.to_a.map(&:text)
          @contents << [title.text, body.join(' ')]
        end
      rescue NoMethodError
        sleep 2
        @attempts += 1
        retry if @attempts < 5
      end
      @attempts += 1
    end
  end

  def update_requests
    @settings[@subreddit_name]['total_requests'] += @attempts
  end

  def reset_requests?
    call_date = @settings[@subreddit_name]['call_date']
    format = '%Y-%m-%d %H:%M:%S %z'
    Time.new - Time.strptime(call_date, format) >= 86_400
  end

  def reset_requests
    @settings[@subreddit_name]['total_requests'] = 0
  end

  def reset_call_date
    @settings[@subreddit_name]['call_date'] = Time.new
  end
end
