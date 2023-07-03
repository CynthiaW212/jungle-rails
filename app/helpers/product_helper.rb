module ProductHelper

  def sold_out_button(product)
    if product.sold_out?
      content_tag(:button, 'Sold Out', class: 'soldout')
    end
  end

  def add_button_disabled(product)
    'disabled' if product.sold_out?
  end
end
