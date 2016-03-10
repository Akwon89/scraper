require_relative'comment'
require'nokogiri'
require'open-uri'


class Post

  attr_reader :url, :title, :points, :item_id, :username, :comments

  def initialize(url)
    @url=url
    @title = url.search('title')[0].text
    @points = url.search('.score').text.to_i
    @username = url.search('.comment-tree .comhead > a:first-child').map {|user| user.inner_text}
    @item_id = url.search('td.subtext > span.score').attribute('id').to_s[/\d*$/].to_i
    @comments = []
    extract_comments
  end


  def extract_comments
    comments_arr = url.search('.comment > span:first-child').map{|comment| comment.inner_text[0..-78]}
    item_id_arr = url.search('.comment-tree .age > a').map{|link| link['href'][/\d*$/].to_i}
    user_id = url.search('.comment-tree .comhead > a:first-child').map {|user| user.inner_text}
      48.times do |i|
        add_comment(comments_arr[i], item_id_arr[i], user_id[i])
      end
  end

 
  def add_comment(text, item_id, username)
    comment = Comment.new(text, item_id, username)
    @comments << comment
    comment
  end

end