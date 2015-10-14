require 'rails_helper'

describe 'deleting todo items' do
  let!(:todo_list) { TodoList.create(title: 'Grocery list', description: 'Groceries that i need to buy.') }
  let!(:todo_item) { todo_list.todo_items.create(content: 'Milk') }

  before do
    user = User.create(email: 'test@test.com', password: '12345678',
      password_confirmation: '12345678')
    login_as user
  end

  it 'should successfully destroy an item' do
    visit_todo_list(todo_list)
    within("#todo_item_#{todo_item.id}") do
      click_link('Delete')
    end
    expect(page).to have_content('Deleted todo list item.')
    expect(TodoItem.count).to eq(0)
  end


end