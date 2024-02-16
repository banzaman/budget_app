require 'rails_helper'

RSpec.describe 'Homes', type: :request do
  include Devise::Test::IntegrationHelpers

  describe 'GET /index' do
    before do
      @user = User.create(email: 'email@email.com', password: 'password')
      sign_in @user
    end

    it 'returns http success' do
      get '/home/index'
      expect(response).to have_http_status(:redirect)
      follow_redirect!
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    before do
      @user = User.create(email: 'email@email.com', password: 'password')
      sign_in @user
    end

    it 'returns http success' do
      category = Group.create(name: 'Category Name')
      get "/home/show/#{category.id}"
      expect(response).to have_http_status(:redirect)
      follow_redirect!
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    before do
      @user = User.create(email: 'email@email.com', password: 'password')
      sign_in @user
    end

    it 'creates a new category' do
      category_params = {
        group: {
          name: 'New Category',
          icon: 'category_icon.png'
        }
      }
      post '/home/create', params: category_params
      expect(response).to have_http_status(:redirect)
    end
  end
end