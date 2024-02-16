class Group < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :entities, class_name: 'Entity', foreign_key: 'group_id', dependent: :destroy

  validates :name, presence: true, length: { minimum: 3, maximum: 80 }
  validates :icon, presence: true
end