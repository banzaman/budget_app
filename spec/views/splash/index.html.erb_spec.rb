require 'rails_helper'

RSpec.describe 'splash/index.html.erb', type: :view do
  describe 'view file' do
    it 'displays the title correctly' do
      render

      expect(rendered).to have_css('h1', text: 'BudgetApp')
    end
  end
end
