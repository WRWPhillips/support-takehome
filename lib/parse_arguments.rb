
class ParseArgs
    def initialize(filters, csv_file)
        raise ArgumentError, "Acceptable filters are 'email', 'phone', 'first_name', 'zip', and 'last_name'" unless filters.all? { |i| ["email", "phone", "first_name", "zip", "last_name"].include? i }
        @filters = filters
        raise ArgumentError, "Improper file format" unless csv_file.include? ".csv"
        @csv_file = csv_file
    end

    private
end