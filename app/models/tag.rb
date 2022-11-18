class Tag < ApplicationRecord
  # has_closure_tree order: 'sort_order', numeric_order: true, dont_order_roots: true
  acts_as_tree
  acts_as_list scope: [:parent_id]
end

