# require 'rails_helper'

# describe 'creating todo_lists' do

#   def create_todo_list(options={})
#     options[:title] ||= "Shopping list"
#     options[:description] ||= "What i have to buy"

#     visit '/todo_lists'
#     click_link 'New Todo list'
#     expect(page).to have_content 'New Todo List'

#     fill_in 'Title', with: options[:title]
#     fill_in 'Description', with: options[:description]
#     click_button 'Create Todo list'
#   end