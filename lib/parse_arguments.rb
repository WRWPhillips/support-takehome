# frozen_string_literal: true

require './lib/get_duplicates'

class ParseArgs

    def initialize(filters, csv_file)
        raise ArgumentError, "Acceptable filters are 'email', 'phone', 'first_name', and 'last_name'" unless filters.all? { |i| ["email", "phone", "first_name", "last_name"].include? i }
        @filters = filters
        raise ArgumentError, "Improper file format" unless csv_file.include? ".csv"
        @csv_file = csv_file
    end

    def test()
        puts @filters
        puts @csv_file
        GetDups.new(@filters, @csv_file).create
    end
    private
    
end