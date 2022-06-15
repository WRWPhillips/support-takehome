# phonelib gem import
require "phonelib"

# user class kind of works like a struct, just a standard way to hold 
# data from each row with inherited methods that are helpful
class User 
    # initialize checks to see whether the row is 5 or 7 columns
    # in order to account for the email1, email2 thing in some
    # files and not in others. It also calls the normalize function
    # on the phone numbers so they can be compared better.
    def initialize(row)
        if row.length == 7
            @user_id = nil 
            @first = row[0]
            @last = row[1]
            @phone = [normalize(row[2]), normalize(row[3])]
            @email = [row[4], row[5]]
            @zip = row[6]
        else 
            @user_id = nil
            @first = row[0]
            @last = row[1]
            @phone = [normalize(row[2])]
            @email = [row[3]]
            @zip = row[4]
        end 
    end

    # accessor for user_id because I need to get and set it, reader
    # for everything else
    attr_accessor :user_id
    attr_reader :first, :last, :phone, :email, :zip 

    # I didn't really know what to call this one but it reminded me of a stringer
    # except that it needs to return an array for a row, so I called it rower
    def rower
        [user_id, first, last] + phone + email + [zip]
    end 

    private 

    # this is the only gem used, just normalizes phone numbers
    def normalize(phone)
        if phone == nil
            nil 
        else
            Phonelib.parse(phone).full_e164
        end
    end
end