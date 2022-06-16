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
    # and then creating a new file inside of the outputs folder with a dynamic name
    # that represents the final product. It goes line by line down the array of users
    # calling the rower method (not a stringer) on the user class and shoveling that 
    # into the output file.
    def output
        assign_ids()
        CSV.open("./outputs/#{File.basename(csv_file, ".csv")}_matched_#{Time.now.to_i}.csv", "w",
            :write_headers => true,
            :headers => headers.unshift("User_id")
        ) do |csv|
            array_of_users.each do |user|
                csv << user.rower
            end
        end
    end

    # array_of_users reads the input csv file by row, pumps the rows into the User 
    # object, appends each object into an array, and then returns the array. 
    # headers: true is important here because it means
    # the csv row objects are hashed, with :header => value
    def array_of_users
        arr = []
        CSV.foreach((csv_file), headers: true) do |row|
            arr << User.new(row)
        end 
        @array_of_users ||= arr
    end

    # assign_ids creates a hash of hashes based on the number of filters. It then
    # uses nested for loops to check for repeating values and either assign a new 
    # user_id or reuse an old one with a value that's already hashed. It gets the 
    # value for comparison with a public_send in order to be more dynamic
    # you can see that 
    def assign_ids
        filter_keys = Hash.new()
        filters.each do |filter|
            filter_keys[filter] = Hash.new()
        end 
        user_id = 0
        array_of_users.each do |user|
            filters.each do |filter|
                values = user.public_send("#{filter}")
                puts values.class
                if ["email", "phone"].include?(filter) && values.class == Array
                    if  values.all?{ |v| v.nil?}
                        user.user_id = user_id
                        user_id += 1
                    elsif filter_keys[filter].key?(values[0]) && !filter_keys[filter].key?(values[1]) && values[0] != nil
                        user.user_id = filter_keys[filter][values[0]]
                    elsif !filter_keys[filter].key?(values[0]) && filter_keys[filter].key?(values[1]) && values[0] != nil
                        user.user_id = filter_keys[filter][values[1]]
                    elsif values[0].nil? && !values[1].nil? 
                        filter_keys[filter][values[1]] = user_id
                        user.user_id = user_id
                        user_id += 1
                    else 
                        filter_keys[filter][values[0]] = user_id
                        user.user_id = user_id
                        user_id += 1
                    end
                else 
                    if !filter_keys[filter].key?(values) && !values.nil?
                        filter_keys[filter][values] = user_id
                        user.user_id = user_id
                        user_id += 1
                    elsif values.nil?
                        user.user_id = user_id
                        user_id += 1
                    else 
                        user.user_id = filter_keys[filter][values]
                    end 
                end 
            end
        end 
    end

    # headers is a super simple method to get the headers into an array, that's it!
    def headers 
        @headers ||= CSV.open("./#{csv_file}", &:readline)
    end

end 