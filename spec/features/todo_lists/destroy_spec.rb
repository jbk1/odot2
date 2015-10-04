require 'rails_helper' #or should this be 'rails_helper'?

describe 'deleting todo_lists' do
  let!(:todo_list) { TodoList.create(title: 'Grocery list', description: 'Groceries that i need to buy.') }

  it 'is successful on clicking desroy link' do
    visit '/todo_lists'

    within "#todo_list_#{todo_list.id}" do
      click_link 'Destroy'
    end

    expect(page).to_not have_content(todo_list.title)
    expect(TodoList.count).to eq(0)
  end
end