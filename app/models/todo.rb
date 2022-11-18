class Todo < ApplicationRecord
  acts_as_tree
  acts_as_list scope: [:parent_id]
end
