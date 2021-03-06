class Product < ActiveRecord::Base
  belongs_to :category
  belongs_to :main_category
  has_many :line_items
  has_many :orders, through: :line_items
  has_many :reviews
  
  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, :description, :image_url, presence: true
  validates_length_of :title, :minimum => 5
  validates_length_of :title, :maximum => 60
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)\Z}i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }

  def self.latest
    Product.order(:updated_at).last
  end

  private

  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, 'Line items exist')
      return false
    end
  end
end
