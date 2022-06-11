# Programming Exercise - Support Engineer

The goal of this exercise is to identify rows in a CSV file that
__may__ represent the __same person__ based on a provided __Matching Type__ (definition below).

The resulting program should allow us to test at least three matching types:
 - one that matches records with the same email address
 - one that matches records with the same phone number
 - one that matches records with the same email address **OR** the same phone number

<br>

# Guidelines

## Running your program
The entry point for your code should be the `match_users.rb` file. The program should take at least two parameters:

```
ruby match_users.rb <..one_or_more_matching_types> <input_filename.csv>
```
eg. `ruby match_users.rb email input1.csv`

eg. `ruby match_users.rb email phone input2.csv`

<br>

## Implementing Matching Types

A matching type is a declaration of what logic should be used to compare the rows.

eg. A matching type named same_email might make use of an algorithm that matches rows based on email columns.

<br>

## Output

The expected output is a renamed copy of the original CSV file, but with an additional unique identifier (eg. user_id) prepended to the row to indicate the same person based on the matcher.

<br>

# Resources

## Please **DO NOT** publically fork this repository
* Clone the repository and create a new repo as your submission
* We expect you to use Ruby, but Python or Javascript may be acceptable depending on your circumstances
* Only use code that you have license to use, but try to limit the use of external libraries/gems
* Don't hesitate to ask us any questions to clarify the project

<br>

## CSV Files

Three sample input files are included. Each file should be processed independently by the resulting code.

<br>

# Scoring Guide

## Running your program
- Does this run from command line as instructed?
- Does it run without errors?

## Implement Matching Types
- Can it match on a single column?
- Do similar columns match to one another?
- Are you able to use multiple matchers?

## Output
- Is there a csv file?
- Are there IDs prepended to each row?

## Coding Style
- Is it readable?
- Is it consistent?

## PLANNING
- The goal is to identify CSV rows that might be the same person based on matching type. The type is passed in as a command line argument, and more than one of them might be applicable. Syntax is ruby match_users.rb [ filter ] [ csv file ].
- Ruby has a really good standard library class for CSVs that I can use.
- First step will be to parse ARGV, OptionsParser not an option because in the readme it says there will be no dash on the args passed in. ARGV[-1] will always be the CSV file name, and every other arg will be a filter. Filters should be email, phone, first_name, and last_name.
- This is a good thing to start on, after this I'll need to call a controller that can work on the CSV. This involves CSV.read() and then csv files can be iterated over by column or row, I believe. This part of the process will not be terrible. I then need to iterate based on the column matching the filter(s) passed in. It might make sense to keep the array of args other than the file name as something to iterate over. If there's only one filter it will only have to be done once.
- There needs to be a new column attached to the CSV and every entry needs a user_id. This is tricky
