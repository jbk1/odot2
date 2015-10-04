class TodoList < ActiveRecord::Base
  validates :title, presence: true, length: { minimum: 2 }
  validates :description, presence: true, length: { minimum: 5 }

  has_many :todo_items
end
