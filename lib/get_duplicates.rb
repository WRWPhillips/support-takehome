# frozen_string_literal: true

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
    output
  end

  private

  attr_reader :filters, :csv_file

  # output makes use of every other private function, calling assign_ids
  # and then creating a new file inside of the outputs folder with a dynamic name,
  # that represents the final product. It goes line by line down the input csv
  # reading lines of the input and instantiating new user classes and then calling the rower method
  # (not a stringer) on the user class and shoveling that into the output file.
  # This maximizes efficiency and allows for one passthrough.
  def output
    user_id = 0
    CSV.open("./outputs/#{File.basename(csv_file, '.csv')}_matched_#{Time.now.to_i}.csv", 'w',
             write_headers: true,
             headers: headers.unshift('User_id')) do |csv|
      CSV.foreach(csv_file, headers: true) do |row|
        user = User.new(row)
        user_id = assign_id(user, user_id)
        csv << user.to_row
      end
    end
  end

  # assign_id calls existing_user_id to see whether ids are hashed for any of 
  # the values for the filters specified. If there are user.user_id is set to
  # the already hashed ids, if not it's set to user_id incremented. After that 
  # ids are assigned to all of the values for the filters specified inside of
  # the filter_keys hash 
  def assign_id(user, user_id)
    user.user_id = existing_user_id(user) || user_id + 1
    update_filters(user)

    user.user_id
  end

  # compact allows for filtering out of null values
  def existing_user_id(user)
    filters.flat_map do |filter|
      user.normalized(filter).map do |data|
        filter_keys[filter][data]
      end
    end.compact.first
  end

  # updates hash for each value with the current user_id (now attached to instance
  # of user)
  def update_filters(user)
    filters.each do |filter|
      user.normalized(filter).each do |data|
        filter_keys[filter][data] = user.user_id
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
    filter_keys = {}
    filters.each do |filter|
      filter_keys[filter] = {}
    end
    @filter_keys ||= filter_keys
  end
end
