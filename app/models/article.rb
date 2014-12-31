class Article < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  validates :title, presence: true,
                    length: { minimum: 3 }

  belongs_to :user 

  def self.comment_num
    Comment.select('article_id, count(*) comments_number')
           .joins(:article)
           .group(:article_id)
           .order('comments_number desc')
           .limit(5)
  end

end
