module ActiveViewComponent
  module Core
    module Facet
      class Generator
        include ActiveViewComponent::Core::Concern::ViewBlock
        include ActiveViewComponent::Core::Concern::Files

        def self.create_view_block_hier(generator_klass:, file:, view_block_node:)
          p "#{self} create_view_block_hier"

          view_block_node = Core::ViewBlockNode.new(
            generator_klass: generator_klass,
            view_block_node: view_block_node
          )

          generator_klass.create_sub_view_blocks(
            file: file,
            view_block_node: view_block_node
          )

          view_block_node
        end

        def self.create_sub_view_blocks(file:, view_block_node:)
          peer_folders(file: file).each do |module_name|
            view_block_generator_for(klassname: module_name).create_view_block(view_block_node: view_block_node)
          rescue StandardError => e
            p "Error creating sub_view_block from #{self} to #{module_name}: #{e.message}. Continuing..."
          end
        end
      end
    end
  end
end
