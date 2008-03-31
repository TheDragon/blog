class Post < ActiveRecord::Base
  has_many :comments
  belongs_to :user

  validates_presence_of :title, :body

  def to_param
    # Here's the pattern I'm using:
    #
    # "#{id}-#{title.downcase.gsub(/[^[:alnum:]]/, '-')}".gsub(/-{2,}/, '-')
    #
    # The 1st gsub replaces any non-alphanumeric chars with a hyphen,
    # the 2nd gsub changes multiple hyphens into a single.
    "#{id}-#{title.downcase.gsub(/[^a-z0-9]+/i, '-')}"
  end
end
