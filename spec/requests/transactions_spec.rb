require 'rails_helper'

RSpec.describe 'Transactions', type: :request do
  include Devise::Test::IntegrationHelpers

  describe 'GET /new' do
    before do
      @user = User.create(email: 'email@email.com', password: 'password')
      sign_in @user
      @category = Group.new(name: 'New Group', icon: 'ICON')
    end

    it 'returns http success' do
      get "/home/index/#{@category.id}/new"
      expect(response).to have_http_status(:redirect)
      follow_redirect!
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /create' do
    before do
      @user = User.create(email: 'email@email.com', password: 'password')
      sign_in @user
      @category = Group.new(name: 'New Group', icon: 'ICON')
    end

    it 'creates transaction' do
      post "/home/index/#{@category.id}", params: { entity: { name: 'Transaction Name', amount: 10 } }
      expect(response).to have_http_status(:redirect)
      follow_redirect!
      expect(response).to have_http_status(:success)
    end
  end
end