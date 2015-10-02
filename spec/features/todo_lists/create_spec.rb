require 'spec_helper' #or should this be 'rails_helper'?

describe 'creating todo_lists' do
  it 'redirects to the todo_list index page on success' do
    visit '/todo_lists'
    click_link 'New Todo list'
    expect(page).to have_content 'New Todo List'

    fill_in 'Title', with: 'Shopping list'
    fill_in 'Description', with: 'What i have to buy'
    click_button 'Create Todo list'
    expect(page).to have_content 'Shopping list'
  end

  it 'display error when todo list has no title' do
    expect(TodoList.count).to eq(0)

    visit '/todo_lists'
    click_link 'New Todo list'
    expect(page).to have_content 'New Todo List'

    fill_in 'Title', with: ''
    fill_in 'Description', with: 'What i have to buy'
    click_button 'Create Todo list'
    expect(page).to have_content 'error'
    expect(TodoList.count).to eq(0)

    visit '/todo_lists'
    expect(page).to_not have_content 'What i have to buy'
  end

  it 'display error when todo list title is less than 2 chars' do
    expect(TodoList.count).to eq(0)

    visit '/todo_lists'
    click_link 'New Todo list'
    expect(page).to have_content 'New Todo List'

    fill_in 'Title', with: 'A'
    fill_in 'Description', with: 'What i have to buy'
    click_button 'Create Todo list'
    expect(page).to have_content 'error'
    expect(TodoList.count).to eq(0)

    visit '/todo_lists'
    expect(page).to_not have_content 'What i have to buy'
  end
end