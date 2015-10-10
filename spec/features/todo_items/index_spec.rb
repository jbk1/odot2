require 'rails_helper'

  describe 'Viewing todo_items' do
    let!(:todo_list) { TodoList.create(title: 'Grocery list', description: 'Groceries that i need to buy.') }
    # let!(:todo_item) { TodoItem.create(content: 'Buy Bananas') }

    def visit_todo_list_items(list)
      visit '/todo_lists'
      within "#todo_list_#{todo_list.id}" do
        click_link "List Items"
      end
    end

    it 'displays the title of the todo list' do
      visit_todo_list_items(todo_list)
      within('h1') do
        expect(page).to have_content(todo_list.title)
      end
    end

    it 'displays no items when a todo list is empty' do
      visit_todo_list_items(todo_list)
      expect(page.all('ul.todo_items li').size).to eq(0)
    end

    it 'displays item content when todo list has items' do
      todo_list.todo_items.create(content: 'Milk')
      todo_list.todo_items.create(content: 'Eggs')
      
      visit_todo_list_items(todo_list)

      expect(page.all('ul.todo_items li').size).to eq(2)
      
      within "ul.todo_items" do
        expect(page).to have_content('Milk')
        expect(page).to have_content('Eggs')
      end
    end
  end