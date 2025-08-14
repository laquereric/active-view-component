module ActiveViewComponent
  module Component
    module Page
      module Body
        # Generates the default page structure
        class Generator < ActiveViewComponent::Core::Facet::Generator
          def self.create_view_block(parent_view_block_node:)
            p "#{self} create_view_block"
            create_view_block_hier(generator_klass: self, file: __FILE__,
                                   parent_view_block_node: parent_view_block_node)
          end
        end
      end
    end
  end
end
