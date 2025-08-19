module ActiveViewComponent
  module Core
    module Facet
      # Base class for all generators in the ActiveViewComponent framework.
      class Generator
        include ActiveViewComponent::Core::Concern::ViewBlock
        include ActiveViewComponent::Core::Concern::Files

        attr_accessor :generator_file, :children, :view_block

        def initialize
          p "#{self} initialize"
          set_generator_file
          super
        end

        def set_generator_file
          raise "Must override"
        end
        
        def setup_root
          p "setup_root"
          view_block = Core::ViewBlockNode.create(generator: self)
          setup_parent(view_block: view_block)
        end

        def setup_child(view_block:)
          p "#{self} setup_child"
          setup_parent(view_block: view_block)
        end

        #####

        # Setup relationship between this view block and its parent
        def setup_parent(view_block:)
          p "#{self} setup_parent"
          raise "view_block nil!" unless view_block
          @view_block = view_block

          view_block.component = self
            .class.view_block_component_sibling_klass
            .new
            .set_view_block(view_block: view_block)
  
          view_block.props = self
            .class
            .view_block_props_sibling_klass
            .new
            .set_view_block(view_block: view_block)

          view_block.style = self
            .class.view_block_style_sibling_klass
            .new
            .set_view_block(view_block: view_block)
  
          raise " @generator_file is nil. Set in set_generator_file method" unless @generator_file

          get_children
          parent_children

          self
        end

        private

        # NOTE: initialize overriden per subclass - so @file set
        
        def child_generator(module_name:)
          p "#{self} child_generator #{module_name}"
          self
            .class
            .view_block_generator_for(klassname: module_name)
            .new
        end
        
        def child_view_node(child_generator:)
          p "#{self} child_view_node #{child_generator}"
          Core::ViewBlockNode.create(generator_klass: child_generator.class, generator_file: child_generator.generator_file)
        end

        def generate_child(module_name:)
          p "#{self} generate_child #{module_name}"
          generator = child_generator(module_name: module_name)
          view_block = Core::ViewBlockNode.create(generator: generator)
          generator
            .setup_child(view_block: view_block)
            .view_block
        end

        def get_children
          p "#{self} get_children"
          @children = peer_folders.map do |module_name|
            begin
              self.generate_child(module_name: module_name)
              
            rescue StandardError => e
              p "Error in creating get_children from #{self} to #{module_name}: #{e.message}. Continuing..."
            end
          end
          self
        end

        # Link every child node to view_block (self), its parent
        def parent_children
          p "#{self} parent_children"
          @children.map do |child|
            begin
              view_block.add_child(child)
              child
            rescue StandardError => e
              p "Error in creating child from #{self} to #{child}: #{e.message}. Continuing..."
            end
          end
          self
        end
      end
    end
  end
end
