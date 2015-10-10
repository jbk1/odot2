require 'rails_helper'

describe 'deleting todo items' do
  let!(:todo_list) { TodoList.create(title: 'Grocery list', description: 'Groceries that i need to buy.') }
  let!(:todo_item) { todo_list.todo_items.create(content: 'Milk') }

  def visit_todo_list_items(list)
    visit '/todo_lists'
    within "#todo_list_#{todo_list.id}" do
      click_link "List Items"
    end
  end

  it 'should successfully destroy an item' do
    visit_todo_list_items(todo_list)
    within("#todo_item_#{todo_item.id}") do
      click_link('Delete')
    end
    expect(page).to have_content('Deleted todo list item.')
    expect(TodoItem.count).to eq(0)
  end


end