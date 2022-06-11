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
        CSV.open("./outputs/#{File.basename(csv_file, ".csv")}_matched_#{Time.now.to_i}.csv", "w",
            :write_headers => true,
            :headers => headers.unshift("User_id")
        ) do |csv|
            CSV.foreach(("./#{csv_file}")) do |row|
                csv << row.unshift("0")
            end
        end
    end

    def headers 
        @headers ||= CSV.open("./#{csv_file}", &:readline)
    end

    def matched_rows

    end

    def header_filters
        idx_arr = []
        headers.each_with_index do |x, i|
            puts x
            if filter_term_array.include?(x)
                idx_arr.append(i)
            end
        end
        @header_filters ||= idx_arr
    end
    
    def filter_term_array
        term_arr = []
        filters.each do |x|
            if x == "email"
                term_arr += ["Email", "Email1", "Email2"]
            elsif x == "phone"
                term_arr += ["Phone", "Phone1", "Phone2"]
            elsif x == "first_name"
                term_arr += ["FirstName"]
            elsif x == "last_name"
                term_arr += ["LastName"]
            elsif x == "zip"
                term_arr += ["Zip"]
            end
        end
        @filter_term_array ||= term_arr
    end

end

