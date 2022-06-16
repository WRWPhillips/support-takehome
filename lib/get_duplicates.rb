# thank goodness ruby has csv in stdlib
require 'csv'

# class to read incoming CSV, filter, and output new csv file -- only one public function to avoid confusion
class GetDups 
    def initialize(filters, csv_file)
        @filters = filters 
        @csv_file = csv_file 
    end 

    # only public function, just calls output
    def create 
        output()
    end 

    private

    attr_reader :filters 
    attr_reader :csv_file 

    # output makes use of every other private function, calling assign_ids
    # and then creating a new file inside of the outputs folder with a dynamic name,
    # that represents the final product. It goes line by line down the input csv 
    # reading lines of the input and instantiating new user classes and then calling the rower method 
    # (not a stringer) on the user class and shoveling that into the output file.
    # This maximizes efficiency and allows for one passthrough. 
    def output
        user_id = 0
        CSV.open("./outputs/#{File.basename(csv_file, ".csv")}_matched_#{Time.now.to_i}.csv", "w",
            :write_headers => true,
            :headers => headers.unshift("User_id")
        ) do |csv|
            CSV.foreach((csv_file), headers: true) do |row|
                user = User.new(row)
                user_id = assign_id(user, user_id)
                csv << user.rower
            end
        end
    end

    # Uses a for loop to check for hashed values and either assign and return a new 
    # user_id or reuse an old one with a value that's already hashed. It gets the 
    # value for comparison with a public_send in order to be more dynamic
    # you can see that there's pretty intense if/else logic here, this is to 
    # account for the email and phone categories in csvs 2 and 3 which are arrays
    def assign_id(user, user_id)
        filters.each do |filter|
            values = user.public_send("#{filter}")
            if ["email", "phone"].include?(filter) && values.class == Array
                if  values.all?{ |v| v.nil?}
                    user.user_id = user_id
                    return user_id + 1
                elsif filter_keys[filter].key?(values[0]) && !filter_keys[filter].key?(values[1]) && values[0] != nil
                    user.user_id = filter_keys[filter][values[0]]
                    return user_id
                elsif !filter_keys[filter].key?(values[0]) && filter_keys[filter].key?(values[1]) && values[1] != nil
                    user.user_id = filter_keys[filter][values[1]]
                    return user_id
                elsif values[0].nil? && !values[1].nil? 
                    filter_keys[filter][values[1]] = user_id
                    user.user_id = user_id
                    return user_id + 1
                else 
                    filter_keys[filter][values[0]] = user_id
                    user.user_id = user_id
                    return user_id + 1
                end
            else 
                if !filter_keys[filter].key?(values) && !values.nil?
                    filter_keys[filter][values] = user_id
                    user.user_id = user_id
                    return user_id + 1
                elsif values.nil?
                    user.user_id = user_id
                    return user_id + 1
                else 
                    user.user_id = filter_keys[filter][values]
                    return user_id
                end 
            end 
        end
    end

    # headers is a super simple method to get the headers into an array, that's it!
    def headers 
        @headers ||= CSV.open("./#{csv_file}", &:readline)
    end

    # separated out the hashes for id comparison in order to keep them in memory
    # this is a hash of hashes with a new hash for each filter. This structure means
    # the first filter specified takes precedence in the id assignment
    def filter_keys
        filter_keys = Hash.new()
        filters.each do |filter|
            filter_keys[filter] = Hash.new()
        end 
        @filter_keys ||= filter_keys
    end
end 