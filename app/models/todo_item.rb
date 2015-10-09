class TodoItem < ActiveRecord::Base
  validates :content, presence: true, length: { minimum: 2 }
  belongs_to :todo_list
end
