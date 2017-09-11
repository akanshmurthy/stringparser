require_relative 'parser'

# string parser test class
class TestParseString
  def initialize
    @test_parser = ParseString.new("@bob @john (success) such a cool feature; https://twitter.com/jdorfman/status/430511497475670016")
    @mention = "@bob"
    @emoticon = "(success)"
    @link = "https://twitter.com/jdorfman/status/430511497475670016"
  end
  
  def test_mention_parsing
    test_mention = @test_parser.check_for_mentions(@mention)
    puts test_mention == "bob"
  end
  
  def test_emoticon_parsing
    test_emoticon = @test_parser.check_for_emoticons(@emoticon)
    puts test_emoticon == "success"
  end
  
  def test_link_parsing
    test_link = @test_parser.check_for_links(@link)
    puts test_link == { url: "https://twitter.com/jdorfman/status/430511497475670016", title: "Justin Dorfman; on Twitter: \"nice @littlebigdetail from @HipChat (shows hex colors when pasted in chat). http://t.co/7cI6Gjy5pq\"" }
  end
end


# test cases
parser = ParseString.new("@chris you around?")
parser.extract_features
puts parser.return_output

parser = ParseString.new("Good morning! (megusta) (coffee)")
parser.extract_features
puts parser.return_output

parser = ParseString.new("Olympics are starting soon; http://www.nbcolympics.com")
parser.extract_features
puts parser.return_output

parser = ParseString.new("@bob @john (success) such a cool feature; https://twitter.com/jdorfman/status/430511497475670016")
parser.extract_features
puts parser.return_output

test_parser = TestParseString.new
test_parser.test_mention_parsing
test_parser.test_emoticon_parsing
test_parser.test_link_parsing