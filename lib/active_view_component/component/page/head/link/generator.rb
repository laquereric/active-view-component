module ActiveViewComponent
  module Component
    module Page
      module Head
        module Link
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
end
