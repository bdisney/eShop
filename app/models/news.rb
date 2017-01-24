class News < ActiveRecord::Base
  validates :title, :sub_title, :body, :image_url, presence: true
  validates_length_of :title, :minimum => 5
  validates_length_of :title, :maximum => 60

  validates_length_of :sub_title, :minimum => 5
  validates_length_of :sub_title, :maximum => 60

  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)\Z}i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }
end
