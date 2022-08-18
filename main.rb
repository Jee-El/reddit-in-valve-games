require 'open-uri'
require 'nokogiri'
require 'json'

class DadJokesScraper
  def initialize
    unparsed_json = File.read('./config.json')
    @parsed_json = JSON.parse(unparsed_json)

    if @parsed_json['has_to_reset_time']
      @parsed_json['call_date'] = Time.new
      @parsed_json['has_to_reset_time'] = false
    end

    @total_requests = @parsed_json['total_requests']
    @maximum_requests = @parsed_json['maximum_requests']
    @attempts = 0
    @keys = @parsed_json['keys']
    @jokes = []
  end

  def start
    scrape
    update_requests
    remove_empty_or_long_jokes
    @jokes = bind_to_keys
    update_dad_jokes_cfg
    File.write('./config.json', JSON.dump(@parsed_json))
  end

  private

  def scrape
    while @attempts < 5 && @total_requests < @maximum_requests && @jokes.empty?
      begin
        unparsed_page = URI.open('https://www.reddit.com/r/dadjokes')
        parsed_page = Nokogiri::HTML(unparsed_page)
        all_posts = parsed_page.css('.rpBJOHq2PR60pnwJlUyP0 > div')
        all_posts.each_with_index do |post, index|
          next if index < 3

          post = post.children[0].children[0].children[2].children
          title = post[1]
          4.times { title = title.children[0] }
          description = post[2]
          4.times { description = description.children[0] }
          @jokes << [title.text, description.text]
        end
      rescue NoMethodError
        sleep 2
        @attempts += 1
        retry if @attempts < 5
      end
      @attempts += 1
    end
  end

  def bind_to_keys
    if @jokes.flatten.length > @keys.length
      @keys.zip(@jokes.flatten).map { |key, joke| "bind \"#{key}\" \"say #{joke}\"" }
    else
      @jokes.flatten.zip(@keys).map { |joke, key| "bind \"#{key}\" \"say #{joke}\"" }
    end
  end

  def remove_empty_or_long_jokes
    # long jokes = past the game's chat's character limit
    @jokes.filter! { |joke| joke.none? { |joke_part| joke_part.empty? || joke_part.length >= 255 } }
  end

  def update_requests
    @parsed_json['total_requests'] += @attempts
    reset_requests if reset_requests?
  end

  def reset_requests?
    Time.new - Time.parse(@parsed_json['call_date'].to_s) >= 86_400
  end

  def reset_requests
    @parsed_json['total_requests'] = 0
    @parsed_json['has_to_reset_time'] = true
  end

  def update_dad_jokes_cfg
    return puts 'No jokes were returned, so your .cfg file should have the same jokes as before' if @jokes.empty?

    @parsed_json['dad_jokes_cfgs'].each { |cfg| File.write(cfg, (@jokes + ['host_writeconfig']).join("\n")) }
    puts 'New jokes were returned, your .cfg file was updated.'
    puts 'They might be the same jokes as before, try again after a few hours if that\'s the case'
  end
end

DadJokesScraper.new.start
