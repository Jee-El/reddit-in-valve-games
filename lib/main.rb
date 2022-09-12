# frozen_string_literal: true

require_relative './scraper'
require_relative './contents_parser'
require_relative './configs_manager'

scraper = Scraper.new
contents_parser = ContentsParser.new(*scraper.start)
configs_manager = ConfigsManager.new(*contents_parser.parse)
configs_manager.update
