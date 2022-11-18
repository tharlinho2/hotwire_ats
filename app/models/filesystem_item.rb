class FilesystemItem < ApplicationRecord
  has_closure_tree order: :position, numeric_order: true
  acts_as_list scope: [:parent_id]
end
