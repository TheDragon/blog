class Post < ActiveRecord::Base
  has_many :comments
  validates_presence_of :title, :body

  def to_param
    "#{id}-#{title.downcase.gsub(/[^a-z0-9]+/i, '-')}"
  end
end
