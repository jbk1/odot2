require 'rails_helper'

  describe 'Viewing todo_items' do
    let!(:todo_list) { TodoList.create(title: 'Grocery list', description: 'Groceries that i need to buy.') }

    it 'displays the title of the todo list' do
      visit_todo_list(todo_list)
      within('h1') do
        expect(page).to have_content(todo_list.title)
      end
    end

    it 'displays no items when a todo list is empty' do
      visit_todo_list(todo_list)
      expect(page.all('.todo_items tr').size).to eq(1)#1 becasue some styling
    end # is fitted in a row in thead!

    it 'displays item content when todo list has items' do
      todo_list.todo_items.create(content: 'Milk')
      todo_list.todo_items.create(content: 'Eggs')
      
      visit_todo_list(todo_list)

      expect(page.all('.todo_items tr').size).to eq(3) 
      #3 not 2 becasue some styling is fitted in a row in thead!
      within ".todo_items" do
        expect(page).to have_content('Milk')
        expect(page).to have_content('Eggs')
      end
    end
  end