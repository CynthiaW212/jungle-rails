require 'rails_helper'

RSpec.describe User, type: :model do

#   It must be created with a password and password_confirmation fields
# These need to match so you should have an example for where they are not the same
# These are required when creating the model so you should also have an example for this
# Emails must be unique (not case sensitive; for example, TEST@TEST.com should not be allowed if test@test.COM is in the database)
# Email, first name, and last name should also be required
  describe 'Validations' do
    it 'is valid with valid attributes' do
      user = User.new(
        name: 'Sanjia',
        email: 'sanjia@gmail.com',
        password:'thisissecret',
        password_confirmation: 'thisissecret'
      )
      expect(user).to be_valid
    end

    it 'is invalid without a name' do
      user = User.new(
        email: 'sanjia@gmail.com',
        password:'thisissecret',
        password_confirmation: 'thisissecret'
      )
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Name can't be blank")
    end

    it 'is invalid without a valid email format' do
      user = User.new(
        name: 'Sanjia',
        email: 'invalid_email',
        password:'thisissecret',
        password_confirmation: 'thisissecret'
      )
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Email is invalid")
    end

    it 'is invalid with a duplicate email' do
      existing_user = User.create(
        name: 'Jane Doe',
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
      user = User.new(
        name: 'John Doe',
        email: 'TEST@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Email has already been taken")
    end

    it 'is invalid without a password' do
      user = User.new(
        name: 'John Doe',
        email: 'test@example.com',
        password_confirmation: 'password'
      )
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it 'is invalid with a password less than 6 characters' do
      user = User.new(
        name: 'John Doe',
        email: 'test@example.com',
        password: 'pass',
        password_confirmation: 'pass'
      )
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it 'is invalid without a password_confirmation' do
      user = User.new(
        name: 'John Doe',
        email: 'test@example.com',
        password: 'password'
      )
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Password confirmation can't be blank")
    end
  end
  describe '.authenticate_with_credentials' do
    before(:each) do
      @user = User.create(
        name: 'John Doe',
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
    end
  
    it 'returns the user when given valid credentials' do
      authenticated_user = User.authenticate_with_credentials('test@example.com', 'password')
      expect(authenticated_user).to eq(@user)
    end
  
    it 'returns nil when given invalid email' do
      authenticated_user = User.authenticate_with_credentials('invalid_email@example.com', 'password')
      expect(authenticated_user).to be_nil
    end

    it 'returns nil when given incorrect password' do
      authenticated_user = User.authenticate_with_credentials('test@example.com', 'incorrect_password')
      expect(authenticated_user).to be_nil
    end

    it 'returns the user when given email with leading/trailing spaces' do
      authenticated_user = User.authenticate_with_credentials('  test@example.com  ', 'password')
      expect(authenticated_user).to eq(@user)
    end

    it 'returns the user when given email with different cases' do
      authenticated_user = User.authenticate_with_credentials('TEST@example.com', 'password')
      expect(authenticated_user).to eq(@user)
    end

    it 'ignores leading/trailing spaces in the email' do
      authenticated_user = User.authenticate_with_credentials('  test@example.com  ', 'password')
      expect(authenticated_user).to eq(@user)
    end
    
    it 'ignores case sensitivity in the email' do
      authenticated_user = User.authenticate_with_credentials('TEST@example.com', 'password')
      expect(authenticated_user).to eq(@user)
    end

    
  end

end
