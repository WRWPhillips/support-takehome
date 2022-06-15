require 'csv'

class GetDups 
    def initialize(filters, csv_file)
        @filters = filters 
        @csv_file = csv_file 
    end 

    def create 
        output()
    end 

    private

    attr_reader :filters 
    attr_reader :csv_file 

    def output
        assign_ids(array_of_users, filters)
        CSV.open("./outputs/#{File.basename(csv_file, ".csv")}_matched_#{Time.now.to_i}.csv", "w",
            :write_headers => true,
            :headers => headers.unshift("User_id")
        ) do |csv|
            array_of_users.each do |user|
                csv << user.rower
            end
        end
    end

    def headers 
        @headers ||= CSV.open("./#{csv_file}", &:readline)
    end

    def array_of_users
        arr = []
        CSV.foreach((csv_file), headers: true) do |row|
            arr << User.new(row)
        end 
        @array_of_users ||= arr
    end

    def assign_ids(user_array, filters)
        filter_keys = Hash.new()
        filters.each do |filter|
            filter_keys[filter] = Hash.new()
        end 
        user_id = 0
        user_array.each do |user|
            filters.each do |filter|
                value = user.public_send("#{filter}")
                if filter_keys[filter][value] == nil && value[0] != nil
                    filter_keys[filter][value] = user_id
                    user.user_id = user_id
                    user_id += 1
                elsif value[0] == nil 
                    user.user_id = user_id
                    user_id += 1
                else 
                    user.user_id = filter_keys[filter][value]
                end 
            end
        end 
    end
end 