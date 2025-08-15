module ActiveViewComponent
  module Component
    module Page
      module Head
        # Generates the default page structure
        class Generator < Core::Facet::Generator
          def set_file
            @file = __FILE__
            self
          end
        end
      end
    end
  end
end
