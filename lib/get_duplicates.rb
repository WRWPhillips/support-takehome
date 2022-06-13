require 'csv'

class GetDups

    def initialize(filters, csv_file)
        @filters = filters
        @csv_file = csv_file
    end

    def create
        puts "filtered csv created at: "
        output()
        puts array_of_rows
        puts filter_dups
    end
        
    private

    attr_reader :filters
    attr_reader :csv_file

    def output
        CSV.open("./outputs/#{File.basename(csv_file, ".csv")}_matched_#{Time.now.to_i}.csv", "w",
            :write_headers => true,
            :headers => headers.unshift("User_id")
        ) do |csv|

        end
    end

    def headers 
        @headers ||= CSV.open("./#{csv_file}", &:readline)
    end

    def array_of_rows
        arr = []
        CSV.foreach((csv_file), headers: true) do |row|
            arr << row
        end 
        array_of_rows ||= arr
    end

    def data_section
        @data_section ||= array_of_rows.slice(1, array_of_rows.length - 1)
    end

    def header_filters
        idx_arr = []
        headers.each_with_index do |x, i|
            if filter_term_array.include?(x)
                idx_arr.append(i)
            end
        end
        @header_filters ||= idx_arr
    end

    def filter_dups
        pairs = {}
        id_count = 0
        filter_term_array.each do |filter|
            data_section.each do |row|
                if !pairs.has_key?(row[filter])
                        pairs[:id_count] = []
                        pairs[:id_count] << row[filter]
                        id_count += 1
                        puts pairs[:row[filter]]
                end
            end
            id_count = 0
        end
        return pairs 
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
            else 
                return
            end
        end
        @filter_term_array ||= term_arr
    end

end

