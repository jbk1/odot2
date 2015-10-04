require 'rails_helper' #or should this be 'rails_helper'?

describe 'editing todo_lists' do
  let!(:todo_list) { TodoList.create(title: 'Grocery list', description: 'Groceries that i need to buy.') }

  def update_todo_list(options={})
    options[:title] ||= 'New title'
    options[:description] ||= 'New description'

    todo_list = options[:todo_list]
    
    visit '/todo_lists'
    within "#todo_list_#{todo_list.id}" do
      click_link 'Edit'
    end

    fill_in 'Title', with: options[:title]
    fill_in 'Description', with: options[:description]
    click_button "Update Todo list"
  end

  it 'updates a todo list successfully wht the valid information' do
    update_todo_list(todo_list: todo_list)

    todo_list.reload
    # binding.pry
    expect(page).to have_content('Todo list was successfully updated')
    expect(todo_list.title).to eq('New title')
    expect(todo_list.description).to eq('New description')
  end

  it 'displays an error with no title' do
    update_todo_list(todo_list: todo_list, title: '')
    title = todo_list.title
    description = todo_list.description
    
    todo_list.reload
    expect(page).to have_content('error')
    expect(todo_list.title).to eq(title)
    expect(todo_list.description).to eq(description)
  end

  it 'displays an error a title of <2 chars' do
    update_todo_list(todo_list: todo_list, title: 'A')
    title = todo_list.title
    description = todo_list.description
    
    todo_list.reload
    expect(page).to have_content('error')
    expect(todo_list.title).to eq(title)
    expect(todo_list.description).to eq(description)
  end

  it 'displays an error with no description' do
    update_todo_list(todo_list: todo_list, description: '')
    title = todo_list.title
    description = todo_list.description
    
    todo_list.reload
    expect(page).to have_content('error')
    expect(todo_list.title).to eq(title)
    expect(todo_list.description).to eq(description)
  end

  it 'displays an error a description of <5 chars' do
    update_todo_list(todo_list: todo_list, description: 'What')
    title = todo_list.title
    description = todo_list.description
    
    todo_list.reload
    expect(page).to have_content('error')
    expect(todo_list.title).to eq(title)
    expect(todo_list.description).to eq(description)
  end
end