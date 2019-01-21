# frozen_string_literal: true

class ApplicationController < ActionController::API

  private

  def render_resource(resource, serialized_data = {}, options = {})
    serialized_data = {
      json: ActiveModelSerializers::SerializableResource.new(
        resource, options
      ).serializable_hash
    }
    render serialized_data
  end

  def render_collection(collection, serialized_data = {}, options = {})
    render_resource(collection, serialized_data, options)
  end

  def render_collection_with_page(collection, serialized_data = {}, options = {})
    data = ActiveModelSerializers::SerializableResource.new(collection, options).serializable_hash

    serialized_data[:json] = data.merge(pagination: {
                                          'current' => collection.current_page.to_i,
                                          'next' => collection.next_page.to_i,
                                          'prev' => collection.prev_page.to_i,
                                          'per_page' => data.length,
                                          'total_count' => collection.total_count.to_i,
                                          'total_page' => collection.total_pages.to_i
                                        })
    render serialized_data
  end
end
