module ActiveViewComponent
  module Core
    module Facet
      class Generator
        include ActiveViewComponent::Core::Concern::ViewBlock
        include ActiveViewComponent::Core::Concern::Files

        def self.create_view_block_hier(generator_klass:, file:, parent_view_block_node:)
          p "#{self} create_view_block_hier"

          view_block_node = Core::ViewBlockNode.new(
            generator_klass: generator_klass,
            parent_view_block_node: parent_view_block_node
          )

          generator_klass.create_sub_view_blocks(
            file: __FILE__,
            parent_view_block_node: view_block_node
          )
          
          view_block_node
        end

        def self.create_sub_view_blocks(file:, parent_view_block_node: view_block_node)
          peer_folders(file: __FILE__).each do |module_name|
            view_block_generator_for(klassname: module_name).create_view_block(parent_view_block_node: view_block_node)
          end
        end
      end
    end
  end
end
