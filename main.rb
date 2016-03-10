require_relative'post'
require_relative'comment'
require "pp"
require "nokogiri"
require"open-uri"
require'colorize'


# doc = Nokogiri::HTML(open("post.html"))  

# puts "post number of comments #{doc.css("span.comment").length}"

# title = doc.search('.title')[0].text

# comments = doc.search('span.comment').text

# points = doc.search('.score').text.to_i

# item_id = doc.search('td.subtext > span.score').attribute('id').to_s[/\d*$/].to_i


# item_id_comment = doc.search('.comment-tree .age > a').map{|link| link['href'][/\d*$/].to_i}


# user_id = doc.search('.comment-tree .comhead > a:first-child').map {|user| user.inner_text}


# comment = doc.search('.comment > span:first-child').map{|comment| comment.inner_text}
# comment = doc.search('.comment > span:first-child').map{|comment| comment.inner_text[0..-78]}
# p item_id_comment.size
# p user_id.size

# html_url = open('https://news.ycombinator.com/item?id=7663775')
url = 'https://news.ycombinator.com/item?id=7663775'
# url = "https://www.google.com"

if !(url =~ (/ycombinator/))
  raise StandardError.new("WRONG URL")
else
  html_url = open(url)
  post = Post.new(Nokogiri::HTML(html_url))
  post.extract_comments
  puts "#{post.url.search('.title')[0].text}"
  post.comments.each{ |comment| puts "\n=====================\n#{comment.username}  #{comment.item_id} \n=====================\n #{comment.text}"}
end








