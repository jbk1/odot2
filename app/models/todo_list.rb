class TodoList < ActiveRecord::Base
  has_many :todo_items, dependent: :destroy

  validates :title, presence: true, length: { minimum: 2 }
  validates :description, presence: true, length: { minimum: 5 }

  def has_completed_items?
    todo_items.completed.size > 0
  end

  def has_uncompleted_items?
    todo_items.uncompleted.size > 0
  end

end
