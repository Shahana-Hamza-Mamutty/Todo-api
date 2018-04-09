class TodoList < ApplicationRecord
  has_many :todo_tasks, :dependent => :destroy
  validates :title, presence: true
end
