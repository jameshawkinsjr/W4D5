require 'rails_helper'

RSpec.describe User, type: :model do

  subject(:user) { User.new(username: "Billy", password: "password")}

  describe 'validations' do 
    it { should validate_presence_of(:username)}
    it { should validate_presence_of(:password_digest)}
    it { should validate_presence_of(:session_token)}
  end

  describe 'password getter and setter methods' do
    it 'allows the password to read' do
      expect(user.password).to eq("password")
    end
  end

  describe '::find_by_credentials' do
    context 'with correct credentials' do
      it 'Can find a user by credentials' do
        user = User.create!(username: "Billy", password: "password")
        expect(User.find_by_credentials("Billy", 'password')).to eq(user)
      end
    end

    context 'with incorrect credentials' do
      it 'return nil' do
        user = User.create!(username: "Billy", password: "1234563")
        expect(User.find_by_credentials("Billy", 'password')).to be_nil
      end
    end
  end

  describe '#ensure and reset session token' do
    it 'ensures a user has a session token' do
      expect(user.session_token).to_not be_nil
      expect(user.session_token).to_not be_empty
    end
    it 'resets the session token' do
      
      token = user.session_token
      user.reset_session_token!

      expect(token).to_not eq(user.session_token)
    end
  end




end
