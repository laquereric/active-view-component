module ActiveViewComponent
  module Component
    module Page
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
