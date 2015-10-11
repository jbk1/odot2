class TodoItem < ActiveRecord::Base
  validates :content, presence: true, length: { minimum: 2 }
  belongs_to :todo_list

  scope :completed, -> { where('completed_at is not null') }
  scope :uncompleted, -> { where(completed_at: nil) } 

  def completed?
    !completed_at.blank?
  end

end