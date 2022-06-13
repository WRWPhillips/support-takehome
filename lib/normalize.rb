# class Normalize
#     def initialize(filter_term_array, array_of_rows)
#         @filter_term_array = filter_term_array
#         @array_of_rows = array_of_rows
#     end

#     def normalize 
#         data_section.each do |row|
#             filter_term_array.each do |filter|
#                 puts row[filter]
#             end
#         end
#     end 

#     private

#     attr_reader :array_of_rows
#     attr_reader :filter_term_array

#     def data_section
#         @data_section ||= array_of_rows.slice(1, array_of_rows.length - 1)
#     end

#     def format(str, filter)
#         case filter 
#         when "Email", "Email1", "Email2"

#         when "Zip"

#         when ""
#     end
# end