require 'rails_helper' #or should this be 'rails_helper'?

describe 'editing todo items' do
  let!(:todo_list) { TodoList.create(title: 'Grocery list', description: 'Groceries that i need to buy.') }
  let!(:todo_item) { todo_list.todo_items.create(content: 'Milk') }

  before do
    user = User.create(email: 'test@test.com', password: '12345678',
      password_confirmation: '12345678')
    login_as user
  end

  it 'is succeesful with valid content' do
    visit_todo_list(todo_list)
    within("#todo_item_#{todo_item.id}") do
      click_link('Edit')
    end
    fill_in 'Content', with: 'Lots of milk.'
    click_button('Save')
    expect(page).to have_content('Saved todo list item.')
    todo_item.reload
    expect(todo_item.content).to eq('Lots of milk.')
  end

  it 'is unsuccessful with no content' do
    visit_todo_list(todo_list)
    within("#todo_item_#{todo_item.id}") do
      click_link('Edit')
    end
    fill_in 'Content', with: ''
    click_button('Save')
    expect(page).to_not have_content('Saved todo list item.')
    expect(page).to have_content("Content can't be blank")
    todo_item.reload
    expect(todo_item.content).to eq('Milk')
  end

  it 'is unsuccessful with not enough content' do
    visit_todo_list(todo_list)
    within("#todo_item_#{todo_item.id}") do
      click_link('Edit')
    end
    fill_in 'Content', with: 'A'
    click_button('Save')
    expect(page).to_not have_content('Saved todo list item.')
    expect(page).to have_content("Content is too short")
    todo_item.reload
    expect(todo_item.content).to eq('Milk')
  end
end