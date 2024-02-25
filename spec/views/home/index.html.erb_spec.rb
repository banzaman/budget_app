require 'rails_helper'

RSpec.describe 'categories/index.html.erb', type: :view do
  let(:category1) { create(:category, name: 'Category 1', icon: 'icon1.png') }
  let(:category2) { create(:category, name: 'Category 2', icon: 'icon2.png') }

  before do
    assign(:categories, [category1, category2])
    render
  end

  it 'displays the title' do
    expect(rendered).to have_selector('.title h3', text: 'CATEGORIES')
  end

  it 'displays each category with its icon, name, and total amount' do
    expect(rendered).to have_selector('.categories-container .card', count: 2)

    expect(rendered).to have_selector('.categories-container .card:nth-of-type(1) .card-info p', text: 'Category 1')
    expect(rendered).to have_selector('.categories-container .card:nth-of-type(1) .card-info .category-icon[src="icon1.png"]')
    expect(rendered).to have_selector('.categories-container .card:nth-of-type(1)', text: '$0')

    expect(rendered).to have_selector('.categories-container .card:nth-of-type(2) .card-info p', text: 'Category 2')
    expect(rendered).to have_selector('.categories-container .card:nth-of-type(2) .card-info .category-icon[src="icon2.png"]')
    expect(rendered).to have_selector('.categories-container .card:nth-of-type(2)', text: '$0')
  end

  it 'displays a link to add a new category' do
    expect(rendered).to have_link('ADD CATEGORY', href: home_new_path, class: 'category-new-btn')
  end

  it 'links each category card to its show page' do
    expect(rendered).to have_link(href: home_show_path(category1.id), class: 'card-link')
    expect(rendered).to have_link(href: home_show_path(category2.id), class: 'card-link')
  end
end
