# Your Code Starts Here

# parser class import
require './lib/parse_arguments'

csv_file = ARGV[-1]
filters = ARGV.slice(0, ARGV.length-1)

ParseArgs.new(filters, csv_file).test