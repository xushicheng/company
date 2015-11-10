class Comment < ActiveRecord::Base
  belongs_to :blog
  belongs_to :user

=begin
  validates :content, length: {
    minimum: 15,
    maximum: 255,
    too_short: "你真的有认真留言吗? 都没有15字诶",
    too_long: "你发布的内容太长了, 最多允许255字"  }
=end
end
