require 'rails_helper'


  describe 'Creating todo_items' do
    let!(:todo_list) { TodoList.create(title: 'Grocery list', description: 'Groceries that i need to buy.') }
    # let!(:todo_item) { TodoItem.create(content: 'Buy Bananas') }

    def visit_todo_list(list)
      visit '/todo_lists'
      within "#todo_list_#{todo_list.id}" do
        click_link "List Items"
      end
    end


    it 'is successful with valid content' do
      visit_todo_list(todo_list)
      click_link 'New Todo Item'
      fill_in 'Content', with: 'Milk'
      click_button 'Save'

      expect(page).to have_content('Added todo list item.')
      within('ul.todo_items') do
        expect(page).to have_content('Milk')
      end
    end

    it 'displays an error with no content' do
      visit_todo_list(todo_list)
      click_link 'New Todo Item'
      fill_in 'Content', with: ''
      click_button 'Save'

      within("div.flash") do
        expect(page).to have_content('There was a problem adding that todo list item.')
      end
      expect(page).to have_content("Content can't be blank")
    end

    it 'displays an error with content less than 2 chars' do
      visit_todo_list(todo_list)
      click_link 'New Todo Item'
      fill_in 'Content', with: 'A'
      click_button 'Save'

      within("div.flash") do
        expect(page).to have_content('There was a problem adding that todo list item.')
      end
      expect(page).to have_content("Content is too short")
    end
  end



  # def create_todo_item(options={})
  #   options[:title] ||= "Shopping list"
  #   options[:description] ||= "What i have to buy"

  #   visit '/todo_lists'
  #   click_link 'New Todo list'
  #   expect(page).to have_content 'New Todo List'

  #   fill_in 'Title', with: options[:title]
  #   fill_in 'Description', with: options[:description]
  #   click_button 'Create Todo list'
  # end

