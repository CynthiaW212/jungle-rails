require 'rails_helper'
require './app/models/category.rb'


RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    before(:each) do
      @category = Category.create(name: 'Test')
      @product = Product.new(
        name: 'Leaf',
        price: 15,
        quantity: 20,
        category: @category
      )
    end

    it 'saves successfully when all fields are set' do
      expect(@product).to be_valid
      expect { @product.save }.to change { Product.count }.by(1)
    end

    it 'requires name to be present' do
      @product.name = nil
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'requires price to be present' do
      @product.price_cents = nil
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Price cents is not a number")
    end

    it 'requires quantity to be present' do
      @product.quantity = nil
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'requires category to be present' do
      @product.category = nil
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end  
end
