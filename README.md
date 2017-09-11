# String parser

This is a simple RESTful API endpoint that parses a string for certain features.

## Setup Instructions 

To run, download or clone the repo. Then, issue the following commands:

```
bundle install
ruby server.rb
```

Then, use Postman to issue a POST request to http://localhost:4567/api/v1/parse with the body being a JSON object containing the string to be parsed. For example...
```
{"string" : "hey @chris! how are you doing? I'm (winning) so much at http://google.com"}
```

To run the tests, issue the following command:
```
ruby test_parser.rb
```

## Requirements

  - takes a string as input to an API endpoint
  - recognizes mentions
  - recognizes emoticons
  - recognizes links
  - returns a JSON-like output containing metadata regarding specific features (mentions, emoticons, and links)

  
## Design choices

I chose Sinatra as a framework because it is very fast for creating MVPs, especially ones that don't require data persistence,
and allows for quick, lightweight definitions of API endpoints. I used the Mechanize gem/library because it makes HTML page parsing easy (for the link page title extraction).

## Future considerations to scale current implementation

  - make each of the 3 methods occur in parallel, especially the link retrieval method since that depends on external network factors, as each is independent of the other
  - switch from regex matching (which is slow) to character matching (if we can assume data inputs are consistent and clean so that '@' would always be the first character of the word containing the mention and similar to the '(' in mentions)
  - experiment with different designs so that the parser doesn't have to be instantiated each time a new string is sent in as input
