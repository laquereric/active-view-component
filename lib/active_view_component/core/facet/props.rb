# frozen_string_literal: true

module ActiveViewComponent
  module Core
    module Facet
      # Props for the component
      class Props < Hash
        include ActiveViewComponent::Core::Concern::ViewBlock

        def self.component_class
          [self.class.module_parent_name, "Component"].join("::").constantize
        end

        def base_defs
          @base_defs ||= [
            %i[initialize prepare prepare_children parent children parent= children=],
            %i[to_h to_hash []= [] key? fetch dig clear delete delete_if each each_key],
            %i[each_value empty? eql? except! has_key? has_value? include? invert keep_if],
            %i[keys length merge! merge rehash reject! select! shift size store to_a update],
            %i[values values_at]
          ].flatten
        end

        def self.component_attribute_keys
          component_class.instance_methods(false) - base_defs
        end

        def initialize(**options)
          super()
          # Initialize from options passed by the generator
          options.each do |key, value|
            instance_variable_set("@#{key}", value) if component_attribute_keys.include?("#{key}=")
          end
        end
      end
    end
  end
end
