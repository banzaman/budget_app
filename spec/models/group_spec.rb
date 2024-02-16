require 'rails_helper'

RSpec.describe Group, type: :model do
  describe 'associations' do
    it 'belongs to an author' do
      association = described_class.reflect_on_association(:author)
      expect(association.macro).to eq(:belongs_to)
      expect(association.options[:class_name]).to eq('User')
      expect(association.foreign_key).to eq('author_id')
    end

    it 'has many entities' do
      association = described_class.reflect_on_association(:entities)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:class_name]).to eq('Entity')
      expect(association.foreign_key).to eq('group_id')
    end
  end

  describe 'validations' do
    it 'requires name to be present' do
      group = Group.new
      group.valid?
      expect(group.errors[:name]).to include("can't be blank")
    end

    it 'requires name to have a minimum length of 3' do
      group = Group.new(name: 'ab')
      group.valid?
      expect(group.errors[:name]).to include('is too short (minimum is 3 characters)')
    end

    it 'requires name to have a maximum length of 80' do
      group = Group.new(name: 'a' * 81)
      group.valid?
      expect(group.errors[:name]).to include('is too long (maximum is 80 characters)')
    end

    it 'requires icon to be present' do
      group = Group.new
      group.valid?
      expect(group.errors[:icon]).to include("can't be blank")
    end
  end
end
