module ActiveViewComponent
  module Core
    module Facet
      # Base class for all generators in the ActiveViewComponent framework.
      class Generator
        include ActiveViewComponent::Core::Concern::ViewBlock
        include ActiveViewComponent::Core::Concern::Files

        attr_accessor :file

        def self.create_root_view_block
          new.set_file.create_root_view_block
        end

        def self.create_children_from(view_block_node:)
          new.set_file.create_children_from(view_block_node: view_block_node)
        end

        # NOTE: initialize overriden per subclass - so @file set

        def create_root_view_block
          p "#{self} calling Core::ViewBlockNode.create_root with file: #{file}"
          Core::ViewBlockNode.create_root(generator_klass: self.class, file: file)
        end

        def create_children_from(view_block_node:)
          p "#{self} calling Core::ViewBlockNode.create_children_from with file: #{file}"
          peer_folders.each do |module_name|
            self.class.view_block_generator_for(klassname: module_name).create_children_from(view_block_node: view_block_node)
          rescue StandardError => e
            p "Error in creating create_children_from called from #{self} to #{module_name}: #{e.message}. Continuing..."
          end
        end
      end
    end
  end
end
