class Admin::DashboardController < ApplicationController
  def show
    @products_counter = Product.count
    @categories_counter = Category.count
  end
end
