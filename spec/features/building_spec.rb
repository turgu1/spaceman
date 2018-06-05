require "rails_helper"

describe "managing buildings" do

  before do
    user = create :admin_user
    login_as user, scope: :user
  end

  it "allows for the creation of a new building with one level" do
    visit root_path
    expect(current_path).to eq(root_path)
    Capybara.match = :first
    click_on    'Buildings'
    click_on    'New Building'
    fill_in     'Name', with: 'Building 1'
    fill_in     'Short Name', with: '1'
    fill_in     'Minimum Level', with: '-1'
    fill_in     'Maximum Level', with: '2'
    check       'Allocate Equipment'
    check       'Moving Items'
    attach_file 'Photo', 'spec/support/bldg.jpg'

    click_on 'Add Level'

    # page.save_screenshot 'tmp/screenshot.png'

    within_table 'floor-images' do
      find(:xpath, './/tbody/tr/td[1]/input').set('1')
      find(:xpath, './/tbody/tr/td[2]/input').set('Level 1')
      find(:xpath, './/tbody/tr/td[3]/input').set('spec/support/floor.png')
    end

    click_on 'Create Building'

    expect(page).to have_content('successfully')
  end

  it 'a new building must appears in the buildings menu' do
    create :building, name: 'Building 123'
    visit root_path
    click_on 'Buildings' 
    expect(find('#buildings-menu')).to have_content('Building 123')
  end

  it 'must be selectable from the building menu' do
    create :building, name: 'Building 123'
    visit root_path
    click_on 'Buildings' 
    click_on 'Building 123'
    expect(find('#main-pane')).to have_content('Building 123')
  end  

  it 'appears on the left pane when selected' do
    create :building, name: 'Building 123'
    visit root_path
    click_on 'Buildings' 
    click_on 'Building 123'   
    expect(find('#left-pane')).to have_content('Building 123')
  end

  it 'the levels appears on the left pane when the building is selected' do
    bldg = create :building, name: 'Building 123'
    create :floor_image, name: 'Level 456', building: bldg
    visit root_path
    click_on 'Buildings' 
    click_on 'Building 123'   
    expect(find('#left-pane')).to have_content('Level 456')
  end

end
