require 'rails_helper' #or should this be 'rails_helper'?

describe 'deleting todo_lists' do
  let!(:todo_list) { TodoList.create(title: 'Grocery list', description: 'Groceries that i need to buy.') }

  context 'when logged out' do
    it 'is not possible wheb logged out' do
      visit '/todo_lists'

      expect(page).to_not have_link('Delete')
    end
  end

  context 'when logged in' do
    before do
      user = User.create(email: 'test@test.com', password: '12345678',
        password_confirmation: '12345678')
      login_as user
    end
    
    it 'is successful on clicking desroy link' do
      visit '/todo_lists'

      within "#todo_list_#{todo_list.id}" do
        click_link 'Delete'
      end

      expect(page).to_not have_content(todo_list.title)
      expect(TodoList.count).to eq(0)
    end
end
end