require 'rails_helper'

RSpec.describe Entity, type: :model do
  describe 'associations' do
    it 'belongs to an author' do
      association = described_class.reflect_on_association(:author)
      expect(association.macro).to eq(:belongs_to)
      expect(association.options[:class_name]).to eq('User')
      expect(association.foreign_key).to eq('author_id')
    end

    it 'belongs to an group' do
      association = described_class.reflect_on_association(:group)
      expect(association.macro).to eq(:belongs_to)
      expect(association.options[:class_name]).to eq('Group')
      expect(association.foreign_key).to eq('group_id')
    end
  end

  describe 'validations' do
    it 'requires name to be preset' do
      entity = Entity.new
      entity.valid?
      expect(entity.errors[:name]).to include(/can't be blank/)
    end

    it 'requires name to have a minimum length of 1' do
      entity = Entity.new(name: '')
      entity.valid?
      expect(entity.errors[:name]).to include(/too short/)
    end

    it 'requires name to have a maximum length of 80' do
      entity = Entity.new(name: 'a' * 81)
      entity.valid?
      expect(entity.errors[:name]).to include(/too long/)
    end
  end
end
