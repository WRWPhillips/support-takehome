# Programming Exercise - Support Engineer

The goal of this exercise is to identify rows in a CSV file that
__may__ represent the __same person__ based on a provided __Matching Type__ (definition below).

The resulting program should allow us to test at least three matching types:
 [x] one that matches records with the same email address
 [x] one that matches records with the same phone number
 [x] one that matches records with the same email address **OR** the same phone number

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
[x] Does this run from command line as instructed?
[x] Does it run without errors?

## Implement Matching Types
[x] Can it match on a single column?
[x] Do similar columns match to one another?
[x] Are you able to use multiple matchers?

## Output
[x] Is there a csv file?
[x] Are there IDs prepended to each row? 

## Coding Style
[x] Is it readable?
[x] Is it consistent?

## Usage
Run bundle install and then use the desired syntax from above. If the syntax is wrong the script will tell you!
Outputs will be uniquely named and placed inside of the outputs folder. 

## Implementation
It took a lot of troubleshooting and some different methods, but I ended up deciding on this as my final submission.
I'm sure there's a more optimal way of doing this, but this is the best I could come up with! I have it set so that 
there are three classes called, and one gem for normalizing phone numbers. I get consistent matching even with multiple
filters, and I made it so that every possible filter can be used. The hardest one in terms of speed is of course input3,
but luckily once the first ten thousand lines are parsed all the other ones already have a user_id hashed. I refactored
and refactored until everything could happen in one passthrough inside of get_duplicates.rb, and I think the biggest drag
on performance now is actually the phone number normalization because regex is sort of expensive memory wise. Right now on
my computer parsing input3.csv with email and phone which are the most expensive filters takes one minute and 5 seconds,
which I'm sure could be improved upon but gosh darn it's a huge file! I chose to use the phonelib gem just because it was 
the most efficient and consistent way to normalize all these very abnormal phone numbers. 
