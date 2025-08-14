module ActiveViewComponent
  module Component
    module Page
      module Head
        # Generates the default page structure
        class Generator < Core::Facet::Generator
          def self.create_sub_view_block_s(view_block_node:)
            p "#{self} create_sub_view_block_s"
            create_sub_view_block_s_hier(generator_klass: self, file: __FILE__, view_block_node: view_block_node)
          end
        end
      end
    end
  end
end
