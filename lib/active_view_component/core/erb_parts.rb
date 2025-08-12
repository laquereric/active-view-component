# frozen_string_literal: true

module ActiveViewComponent
  module Core
    # Concern that provides ERB template helpers for components
    # Allows components to define ERB attributes and nodes declaratively
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
            instance_variable_get("@#{name}")
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
              end
            end

            instance_variable_set("@#{name}", value)
          end

          # Define helper method to check if attribute is set
          define_method("#{name}?") do
            !instance_variable_get("@#{name}").nil?
          end
        end

        # Get all defined ERB attributes
        def erb_attributes
          @erb_attributes || {}
        end
        #         # Define an ERB node that represents a child component or section
        #         # @param name [Symbol] The name of the node
        #         # @param options [Hash] Optional configuration for the node
        #         # @option options [Class] :component_class The component class for this node
        #         # @option options [Boolean] :multiple Whether multiple nodes are allowed
        #         # @option options [String] :default_content Default content if no component provided
        #         def erb_node(name, **options)
        #           # Store erb node metadata
        #           @erb_nodes ||= {}
        #           @erb_nodes[name] = options
        #
        #           # Define getter method for single node
        #           if options[:multiple]
        #             define_method(name) do
        #               instance_variable_get("@#{name}") || []
        #             end
        #
        #             define_method("#{name}=") do |nodes|
        #               instance_variable_set("@#{name}", Array(nodes))
        #             end
        #
        #             define_method("add_#{name.to_s.singularize}") do |node|
        #               current_nodes = instance_variable_get("@#{name}") || []
        #               instance_variable_set("@#{name}", current_nodes + [node])
        #             end
        #           else
        #             define_method(name) do
        #               instance_variable_get("@#{name}")
        #             end
        #
        #             define_method("#{name}=") do |node|
        #               instance_variable_set("@#{name}", node)
        #             end
        #           end
        #
        #           # Define helper method to check if node is set
        #           define_method("#{name}?") do
        #             node = instance_variable_get("@#{name}")
        #             options[:multiple] ? !node.nil? && !node.empty? : !node.nil?
        #           end
        #
        #           # Define method to render the node
        #           define_method("render_#{name}") do
        #             node = instance_variable_get("@#{name}")
        #             if node
        #               if options[:multiple]
        #                 node.map { |n| render_node_content(n, options) }.join.html_safe
        #               else
        #                 render_node_content(node, options).html_safe
        #               end
        #             elsif options[:default_content]
        #               options[:default_content].html_safe
        #             else
        #               "".html_safe
        #             end
        #           end
        #         end
        #
        #         # Get all defined ERB nodes
        #         def erb_nodes
        #           @erb_nodes || {}
        #         end
      end

      private

      # Render content for a node, handling different node types
      def render_node_content(node, options)
        case node
        when String
          node
        when Hash
          # If it's a hash, treat it as attributes for the component class
          if options[:component_class]
            component = options[:component_class].new(**node)
            render(component)
          else
            node.to_s
          end
        else
          # If it's already a component instance, render it directly
          if node.respond_to?(:render_in)
            render(node)
          else
            node.to_s
          end
        end
      end
    end
  end
end
