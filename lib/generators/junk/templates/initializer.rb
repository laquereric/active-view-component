# frozen_string_literal: true

ActiveViewComponent.configure do |config|
  # Enable/disable the ActiveViewComponent system
  config.enabled = true
  
  # Automatically persist component trees during rendering
  config.auto_persist = true
end
