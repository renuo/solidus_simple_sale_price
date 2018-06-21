require 'spec_helper'

RSpec.describe 'Configuring sale prices', type: :feature, js: true do
  stub_authorization!

  let!(:product) { create(:product) }

  xit 'Can visit sale prices admin page of a product' do
    visit spree.admin_product_path(product)
    click_link 'Price'
    expect(page).to have_content('Sale price')
  end
end
