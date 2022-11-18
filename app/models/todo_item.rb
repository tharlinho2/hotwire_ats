class TodoItem < ApplicationRecord
  acts_as_list

  belongs_to :todo
end
