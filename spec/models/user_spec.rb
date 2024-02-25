require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it 'has many entities' do
      association = described_class.reflect_on_association(:entities)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:class_name]).to eq('Entity')
      expect(association.foreign_key).to eq('author_id')
    end

    it 'has many groups' do
      association = described_class.reflect_on_association(:groups)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:class_name]).to eq('Group')
      expect(association.foreign_key).to eq('author_id')
    end
  end

  describe 'validations' do
    it 'requires name to be present' do
      user = User.new
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end

    it 'requires name to have a minimum length of 3' do
      user = User.new(name: 'ab')
      user.valid?
      expect(user.errors[:name]).to include('is too short (minimum is 3 characters)')
    end

    it 'requires name to have a maximum length of 16' do
      user = User.new(name: 'abcdefghijklmnopqrstuvwxyz')
      user.valid?
      expect(user.errors[:name]).to include('is too long (maximum is 16 characters)')
    end
  end
end
