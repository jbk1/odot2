require 'rails_helper' #or should this be 'rails_helper'?

describe 'Completing todo items' do
  let!(:todo_list) { TodoList.create(title: 'Grocery list', description: 'Groceries that i need to buy.') }
  let!(:todo_item) { todo_list.todo_items.create(content: 'Milk') }

  before do
    user = User.create(email: 'test@test.com', password: '12345678',
      password_confirmation: '12345678')
    login_as user
  end

  it 'is successful when marking a single item complete' do
    expect(todo_item.completed_at).to be_nil
    visit_todo_list(todo_list)
    within dom_id_for(todo_item) do
      click_link "Mark complete"
    end
    todo_item.reload
    expect(todo_item.completed_at).to_not be_nil
  end

  context 'where item is marked as complete' do
    let!(:completed_todo_item) { todo_list.todo_items.create(content: 'Eggs', completed_at: 5.minutes.ago) }    
  
    it 'shows the completed items as complete' do
      visit_todo_list(todo_list)
      within dom_id_for(completed_todo_item) do
        expect(page).to have_content(completed_todo_item.completed_at)
      end
    end
    
    it "does not show the 'Mark complete' link" do
      visit_todo_list(todo_list)
      within dom_id_for(completed_todo_item) do
        expect(page).to_not have_link('Mark complete')
      end
    end

    it "is possible to mark and item incomplete" do
      visit_todo_list(todo_list)
      within dom_id_for(completed_todo_item) do
        click_link "Mark incomplete"
      end
        todo_item.reload
        expect(page).to_not have_content(completed_todo_item.completed_at)
        expect(page).to have_link "Mark complete"
    end
  end
end