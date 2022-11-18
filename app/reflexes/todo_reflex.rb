# frozen_string_literal: true

class TodoReflex < ApplicationReflex
  def update_record(resource, value)
    id = element.dataset.id
    resource = resource.constantize.find(id)
    resource.update("position": value)

    morph :nothing
  end

end
