require 'csv'

class GetDups

    def initialize(filters, csv_file)
        @filters = filters
        @csv_file = csv_file
    end

    def create
        puts "filtered csv created at: "
        output()
    end
        
    private
    attr_reader :filters
    attr_reader :csv_file

    def output
        CSV.open("./outputs/#{File.basename(csv_file)}_matched_#{Time.now.to_i}.csv", "w",
            :write_headers => true,
            :headers => headers.unshift("user_id")
        ) do |csv|
           csv << arr_of_rows[1]
        end
    end

    def headers 
        @headers ||= CSV.open("./#{csv_file}", &:readline)
    end

    def arr_of_rows
        @arr_of_rows ||= CSV.read("./#{csv_file}", 
            headers: true,
            return_headers: true)
    end

end

