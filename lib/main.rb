# frozen_string_literal: true

require_relative './scraper'
require_relative './parser'
require_relative './files_manager'

scraper = Scraper.new
parser = Parser.new(*scraper.start)
files_manager = FilesManager.new(*parser.parse)
files_manager.update
