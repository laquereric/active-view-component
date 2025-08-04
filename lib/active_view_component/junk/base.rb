# frozen_string_literal: true

require "active_record"
require "ancestry"

module ActiveViewComponent
  class Base < ActiveRecord::Base
    self.table_name = "active_view_components"
    
    # Use ancestry gem for tree structure
    has_ancestry
    
    # Validations
    validates :view_component_class_name, presence: true
    validates :component_data, presence: true
    
    # Serialization for component data
    serialize :component_data, coder: JSON
    serialize :render_options, coder: JSON
    
    # Scopes
    scope :roots, -> { where(ancestry: nil) }
    scope :by_component_class, ->(class_name) { where(view_component_class_name: class_name) }
    
    # Instance methods
    def component_class
      @component_class ||= view_component_class_name.constantize
    end
    
    def instantiate_component
      component_class.new(**component_data.symbolize_keys)
    end
    
    def render_component(view_context)
      component = instantiate_component
      view_context.render(component, **render_options.symbolize_keys)
    end
    
    def self.create_from_component(component, parent: nil, render_options: {})
      create!(
        view_component_class_name: component.class.name,
        component_data: extract_component_data(component),
        render_options: render_options,
        parent: parent
      )
    end
    
    private
    
    def self.extract_component_data(component)
      # Extract instance variables from the component that represent its state
      data = {}
      component.instance_variables.each do |var|
        key = var.to_s.delete("@")
        value = component.instance_variable_get(var)
        # Only include serializable data
        if value.is_a?(String) || value.is_a?(Numeric) || value.is_a?(TrueClass) || 
           value.is_a?(FalseClass) || value.is_a?(Array) || value.is_a?(Hash) || value.nil?
          data[key] = value
        end
      end
      data
    end
  end
end
