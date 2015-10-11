require 'rails_helper'

describe TodoList do
  it { should have_many(:todo_items) }

  describe '#has_completed_items?' do
    let(:todo_list) { TodoList.create(title: 'Grocery list', description: 'Groceries that i need to buy.') }

    it 'returns true with completed todo items' do
      todo_list.todo_items.create(content: "Eggs", completed_at: 1.minute.ago)
      expect(todo_list.has_completed_items?).to be_truthy
    end

    it 'returns false without completed todo items' do
      todo_list.todo_items.create(content: "Eggs")
      expect(todo_list.has_completed_items?).to be_falsey
    end
  end 

  describe '#has_uncompleted_items?' do
    let(:todo_list) { TodoList.create(title: 'Grocery list', description: 'Groceries that i need to buy.') }

    it 'returns true with uncompleted todo items' do
      todo_list.todo_items.create(content: "Eggs")
      expect(todo_list.has_uncompleted_items?).to be_truthy
    end

    it 'returns false without uncompleted todo items' do
      todo_list.todo_items.create(content: "Eggs", completed_at: 1.minute.ago)
      expect(todo_list.has_uncompleted_items?).to be_falsey
    end
  end 

end 
