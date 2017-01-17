class CombineItemsInCart < ActiveRecord::Migration
  def up
    # replace multiple products entries by one entry with quantity
    Cart.all.each do |cart|
      # count quantity of each product in cart
      sums = cart.line_items.group(:product_id).sum(:quantity)

      sums.each do |product_id, quantity|
        if quantity > 1
          # removing individual product entries
          cart.line_items.where(product_id: product_id).delete_all

          # replace of one entry
          item = cart.line_items.build(product_id: product_id)
          item.quantity = quantity
          item.save
        end
      end
    end
  end
end
