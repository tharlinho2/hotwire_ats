class TodoFilho < ApplicationRecord
  belongs_to :todo_list

  acts_as_list scope: :todo_list
end
