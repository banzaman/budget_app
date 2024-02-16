require 'rails_helper'

RSpec.describe 'home/index.html.erb', type: :view do
  describe 'renders correctly' do
    it 'displays categories correctly' do
      categories = [
        Group.new(id: 1, name: 'Category 1', icon: 'icon1'),
        Group.new(id: 2, name: 'Category 2', icon: 'icon2')
      ]

      assign(:categories, categories)

      render

      expect(rendered).to have_css('.title h3', text: 'CATEGORIES')

      categories.each do |category|
        expect(rendered).to have_link(category.name, href: home_show_path(category.id), class: 'card-link')
        expect(rendered).to have_css('.card-category .card-info .category-icon', text: category.icon)
        expect(rendered).to have_css('.card-category .card-info p', text: category.name)
        expect(rendered).to have_css('.card-category p', text: "$#{category.entities.sum(:amount)}")
      end
    end
  end
end
