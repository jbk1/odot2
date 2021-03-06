require 'rails_helper'


  describe 'Creating todo_items' do
    let!(:todo_list) { TodoList.create(title: 'Grocery list', description: 'Groceries that i need to buy.') }


    context 'when logged out' do
      it 'is impossible' do
        visit '/todo_lists'

        expect(page).to_not have_link('List Items')
      end
    end


    context 'when logged in' do
      before do
        user = User.create(email: 'test@test.com', password: '12345678',
          password_confirmation: '12345678')
        login_as user
      end

      it 'is successful with valid content' do
        visit_todo_list(todo_list)
        click_link 'New Todo Item'
        fill_in 'Content', with: 'Milk'
        click_button 'Save'

        expect(page).to have_content('Added todo list item.')
        within('.todo_item') do
          expect(page).to have_content('Milk')
        end
      end

      it 'displays an error with no content' do
        visit_todo_list(todo_list)
        click_link 'New Todo Item'
        fill_in 'Content', with: ''
        click_button 'Save'

        within("div.panel") do
          expect(page).to have_content('There was a problem adding that todo list item.')
        end
        expect(page).to have_content("Content can't be blank")
      end

      it 'displays an error with content less than 2 chars' do
        visit_todo_list(todo_list)
        click_link 'New Todo Item'
        fill_in 'Content', with: 'A'
        click_button 'Save'

        within("div.panel") do
          expect(page).to have_content('There was a problem adding that todo list item.')
        end
        expect(page).to have_content("Content is too short")
      end
    end
  end
