# frozen_string_literal: true

require "rails/engine"

module ActiveViewComponent
  class Engine < ::Rails::Engine
    isolate_namespace ActiveViewComponent
    
    config.generators do |g|
      g.test_framework :rspec
    end
    
    initializer "active_view_component.initialize" do
      ActiveSupport.on_load(:action_controller) do
        include ActiveViewComponent::ControllerExtensions
      end
      
      ActiveSupport.on_load(:action_view) do
        include ActiveViewComponent::ViewHelpers
      end
    end
  end
end
