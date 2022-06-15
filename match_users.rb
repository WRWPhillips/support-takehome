# Your Code Starts Here

# class imports here 
require './lib/parse_arguments'
require './lib/get_duplicates'
require './lib/user'

# calling parseargs to split argv and validate args
args = ParseArgs.new(ARGV)

# initializing and calling GetDups class instance
GetDups.new(args.filters, args.csv_file).create