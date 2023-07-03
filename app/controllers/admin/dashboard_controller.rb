class Admin::DashboardController < ApplicationController
  before_action :authenticate
  def show
    @products_counter = Product.count
    @categories_counter = Category.count
  end
end
