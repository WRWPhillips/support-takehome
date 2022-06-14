class Normalize
    def initialize(phone)
        @phone = phone 
    end

    def normalize 
        phone = Phonelib.parse(phone)
        return phone 
    end 

    private 
end 