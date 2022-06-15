# Class exists to raise argumentErrors and return 

class ParseArgs
    
    def initialize(args)
        @args = args
    end

    def csv_file
        file = ARGV[-1]
        raise ArgumentError, "Improper file format" unless file.include? ".csv"
        @csv_file ||= file
    end 

    def filters 
        arr = ARGV.slice(0, ARGV.length-1)
        raise ArgumentError, "Acceptable filters are 'email', 'phone', 'first_name', 'zip', and 'last_name'" unless arr.all? { |i| ["email", "phone", "first_name", "zip", "last_name"].include? i }
        @filters ||= arr
    end

end 