require'nokogiri'

class Comment

  attr_reader :text, :item_id, :username

  def initialize(text, item_id, username)
    @text = text
    @item_id = item_id
    @username = username
    @comments = []
  end

  def comments
    @comments
  end

  def add_comment(text, item_id, username)
    comment = Comment.new(text, item_id, username)
    @comments << comment
    comment
  end


end
