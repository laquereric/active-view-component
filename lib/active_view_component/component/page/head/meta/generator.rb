module ActiveViewComponent
  module Component
    module Page
      module Head
        module Meta
          # Generates the default page structure
          class Generator < ActiveViewComponent::Core::Facet::Generator
            def self.create_view_block(view_block_node:)
              p "#{self} create_view_block"
              create_view_block_hier(generator_klass: self, file: __FILE__, view_block_node: view_block_node)
            end
          end
        end
      end
    end
  end
end
