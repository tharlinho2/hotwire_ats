class TodoList < ApplicationRecord
  has_many :todo_filhos, -> { order(position: :asc) }

  acts_as_list
end
