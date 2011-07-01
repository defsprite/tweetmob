# the tweetmob.
require 'sinatra'
require 'erb'
require 'twitter'
require  'lib/stopwords'

@@hashtag = "betahaushh"
@@search = Twitter::Search.new.hashtag(@@hashtag).no_retweets.per_page(100)

before do
  content_type :html, 'charset' => 'utf-8'
end

get '/' do
  @words = get_frequencies
  erb :tweets
end

def get_frequencies
  text = @@search.fetch.map(&:text).flatten.join(" ")
  text = text.tr(",'()","").gsub(/"|&quot;/,"")
  words = text.split(" ").reject {|word| Stopwords::LIST.has_key?(word.downcase) }
  freqs = Hash.new(0)
  words.each { |word| freqs[word.downcase] += 1 }
  freqs = freqs.sort_by { |x, y| y }
  freqs.reject! {|k,v| k == "##{@@hashtag}"}
  freqs.reverse!
end

