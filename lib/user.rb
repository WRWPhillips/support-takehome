# frozen_string_literal: true

# phonelib gem import
require 'phonelib'

# user class kind of works like a struct, just a standard way to hold
# data from each row with inherited methods that are helpful
class User
  # initialize checks to see whether the row is 5 or 7 columns
  # in order to account for the email1, email2 thing in some
  # files and not in others. It also calls the normalize function
  # on the phone numbers so they can be compared better.
  def initialize(row)
    if row.length == 7
      @user_id = 0
      @first_name = row[0]
      @last_name = row[1]
      @phone = [fmt(row[2]), fmt(row[3])]
      @email = [row[4], row[5]]
      @zip = row[6]
    else
      @user_id = nil
      @first_name = row[0]
      @last_name = row[1]
      @phone = fmt(row[2])
      @email = row[3]
      @zip = row[4]
    end
  end

  # accessor for user_id because I need to get and set it, reader
  # for everything else
  attr_accessor :user_id
  attr_reader :first_name, :last_name, :phone, :email, :zip

  # returns row as array
  def to_row
    [user_id, first_name, last_name, phone, email, zip].flatten
  end

  # Returns the field based on filter as an array
  def normalized(filter)
    [public_send(filter)].flatten.compact
  end

  private

  # this is the only gem used, just normalizes phone numbers
  def fmt(phone)
    if phone.nil?
      nil
    else
      Phonelib.parse(phone).full_e164
    end
  end
end
