#dependencies
require 'sinatra'
require_relative 'parser'

#endpoint mapping
get '/' do
  'Welcome to the parse. Use the api/vi/parse endpoint to parse.'
end

post '/api/v1/parse' do
  request_object = JSON.parse(request.body.read)
  if request_object
    parsed_string = ParseString.new(request_object["string"])
    parsed_string.extract_features
    parsed_string.return_output.to_json
  else
    {}.to_json
  end
end


