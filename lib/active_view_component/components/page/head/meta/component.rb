# frozen_string_literal: true
module ActiveViewComponent
  module Page
    module Head
      module Meta
        # Meta Component for managing meta tags
        class Component < Base::Component
          def self.props_class
            Props
          end
        end
      end
    end
  end
end
