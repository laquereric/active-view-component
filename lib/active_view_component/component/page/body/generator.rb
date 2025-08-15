module ActiveViewComponent
  module Component
    module Page
      module Body
        # Generates the default page structure
        class Generator < ActiveViewComponent::Core::Facet::Generator
          def set_file
            @file = __FILE__
            self
          end
        end
      end
    end
  end
end
