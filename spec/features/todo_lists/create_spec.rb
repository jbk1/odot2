require 'rails_helper'

describe 'Creating todo_lists' do

  def create_todo_list(options={})
    options[:title] ||= "Shopping list"
    options[:description] ||= "What i have to buy"

    visit '/todo_lists'
    click_link 'New Todo list'
    expect(page).to have_content 'New Todo List'

    fill_in 'Title', with: options[:title]
    fill_in 'Description', with: options[:description]
    click_button 'Create Todo list'
  end


  context 'when not logged in' do
    it 'takes u sto the sign up page' do
      visit '/todo_lists'
      click_link 'New Todo list'

      expect(page).to have_content('Sign up')
    end
  end


  context 'when logged in' do
    it 'redirects to the todo_list index page upon success' do
      create_todo_list
      # binding.pry
      expect(page).to have_content 'Shopping list'
    end


    it 'displays an error when the todo list has no title' do
      expect(TodoList.count).to eq(0)
      create_todo_list(title: '')

      expect(page).to have_content 'error'
      expect(TodoList.count).to eq(0)
      
      visit '/todo_lists'
      expect(page).to_not have_content 'What i have to buy'
    end


    it 'displays an error when the todo list title is <2 chars' do
      expect(TodoList.count).to eq(0)
      create_todo_list(title: 'A')

      expect(page).to have_content 'error'
      expect(TodoList.count).to eq(0)

      visit '/todo_lists'
      expect(page).to_not have_content 'What i have to buy'
    end


    it 'displays an error when the todo list has no description' do
      expect(TodoList.count).to eq(0)
      create_todo_list(description: '')

      expect(page).to have_content 'error'
      expect(TodoList.count).to eq(0)

      visit '/todo_lists'
      expect(page).to_not have_content 'What i have to buy'
    end


    it 'displays an error when the todo list description is <5 chars' do
      expect(TodoList.count).to eq(0)
      create_todo_list(description: 'What')

      expect(page).to have_content 'error'
      expect(TodoList.count).to eq(0)

      visit '/todo_lists'
      expect(page).to_not have_content 'What i have to buy'
    end
  end
end