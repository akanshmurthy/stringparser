require 'mechanize'

# string parser main class
class ParseString
  def initialize(string)
    @tokenized_string = string.split(" ")
    @url_parser = Mechanize.new
    @json_output = { 
      mentions: [],
      emoticons: [],
      links: []
    }
  end
  
  def extract_features
    @tokenized_string.each do |word|
      check_for_mentions(word) if !(/@/ =~ word).nil?
      check_for_emoticons(word) if !(/\(/ =~ word).nil? && !(/\)/ =~ word).nil?
      check_for_links(word) if !(/http/ =~ word).nil?
    end
  end
  
  def check_for_mentions(word)
    starting_index = word.index('@')
    mentioned_person = word[starting_index+1..word.length]
    @json_output[:mentions] << mentioned_person
    mentioned_person
  end
  
  def check_for_emoticons(word)
    starting_index = word.index('(')
    ending_index = word.index(')')
    emoticon = word[starting_index+1..ending_index-1]
    @json_output[:emoticons] << emoticon
    emoticon
  end
  
  def check_for_links(word)
    @url_parser.get(word)
    link_data = {
      url: word,
      title: @url_parser.page.title
    }
    @json_output[:links] << link_data
    link_data
  end
  
  def return_output
    @json_output.delete(:mentions) if @json_output[:mentions].empty?
    @json_output.delete(:emoticons) if @json_output[:emoticons].empty?
    @json_output.delete(:links) if @json_output[:links].empty?
    @json_output
  end
end