# frozen_string_literal: true
module ActiveViewComponent
  module Page
  
# HTML Component for managing the top-level HTML wrapper
class Component < Base::Component
  def self.props_class
    Props
  end
end
end
end

