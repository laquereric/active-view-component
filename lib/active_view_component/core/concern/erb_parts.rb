# frozen_string_literal: true

module ActiveViewComponent
  module Core
    module Concern
      # Concern that provides ERB template helpers for components
      # Allows components to define ERB attributes declaratively
      module ErbParts
        extend ActiveSupport::Concern

        class_methods do
          # Define an ERB attribute that will be available in the template
          # @param name [Symbol] The name of the attribute
          # @param options [Hash] Optional configuration for the attribute
          # @option options [String] :default Default value if not provided
          # @option options [Symbol] :type Expected type (:string, :integer, :boolean, etc.)
          # @option options [Boolean] :required Whether the attribute is required
          def erb_attr(name, **options)
            # Store erb attribute metadata
            @erb_attributes ||= {}
            @erb_attributes[name] = options

            # Define getter method
            define_method(name) do
              #  instance_variable_get("@#{name}")
              case options[:type]
              when :view_block_child
                children_labeled(label: name).map do |child|
                  render(child.component)
                end
              else
                !instance_variable_get("@#{name}").nil?
              end
            end

            # Define setter method
            define_method("#{name}=") do |value|
              # Apply type coercion if specified
              if options[:type] && value
                case options[:type]
                when :integer
                  value = value.to_i
                when :boolean
                  value = !!value
                when :string
                  value = value.to_s
                when :view_block_child
                  value = "calculated_value"
                end
              end

              instance_variable_set("@#{name}", value)
            end

            # Define helper method to check if attribute is set
            define_method("#{name}?") do
              p options[:type]
              case options[:type]
              when :view_block_child
                !instance_variable_get("@#{name}") == "calculated_value"
              else
                !instance_variable_get("@#{name}").nil?
              end
            end
          end

          # Get all defined ERB attributes
          def erb_attributes
            @erb_attributes || {}
          end
        end
      end
    end
  end
end
