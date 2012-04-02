require 'spec_helper'

describe "Products" do
  describe "GET /products" do
    it "it displays products" do
      visit products_path
      page.should have_content("Products")
    end
  end

  it "create product", :js => true do
    visit products_path
    click_link "New Product"
    fill_in "Name", :with => "Cinema LED Display"
    fill_in "Price", :with => "1200.99"
    click_button "Save Product"
    page.should have_content("Cinema LED Display")
  end

  it "filter product name", :js => true do
    visit products_path
    fill_in "product", :with => "Cinema"
    click_button "Filter"
    find('h1').find('small').should have_content('Filtered')
  end
end

feature "Delete product" do
  background do
    Product.create!(:name => 'Trek Fuel EX 8', :price => 2599.99)
  end

  scenario "Deleting product from product catalog" do
    visit products_path
    click_link("Delete")
    #print page.html
  end
end