# Your Code Starts Here

# parser class import
require './lib/parse_arguments'
require './lib/get_duplicates'
require './lib/normalize'

csv_file = ARGV[-1]
filters = ARGV.slice(0, ARGV.length-1)

ParseArgs.new(filters, csv_file)

GetDups.new(filters, csv_file).create