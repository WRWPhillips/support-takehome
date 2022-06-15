require "phonelib"

class User 
    def initialize(row)
        if row.length == 7
            @user_id = nil 
            @first = row[0]
            @last = row[1]
            @phone = [normalize(row[2]), normalize(row[3])]
            @email = [row[4], row[5]]
            @zip = row [6]
        else 
            @user_id = nil
            @first = row[0]
            @last = row[1]
            @phone = [normalize(row[2])]
            @email = [row[3]]
            @zip = row [4]
        end 
    end

    attr_accessor :user_id
    attr_reader :first, :last, :phone, :email, :zip 

    def rower 
        if phone.length == 2
            [user_id,first,last,phone[0],phone[1],email[0],email[1],zip]
        else 
            [user_id,first,last,phone[0],email[0],zip]
        end 
    end 

    private 

    def normalize(phone)
        if phone == nil
            nil 
        else
            Phonelib.parse(phone).full_e164
        end
    end
end