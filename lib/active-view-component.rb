# frozen_string_literal: true

require "rails"
require "ancestry"
require "view_component"

# Load pry for development and testing
begin
  require "pry"
rescue LoadError
  # Pry not available, continue without it
end

require_relative "active_view_component/version"
require_relative "active_view_component/engine"

require_relative "active_view_component/core/facet/component"
require_relative "active_view_component/core/facet/props"
require_relative "active_view_component/core/facet/style"
require_relative "active_view_component/core/node"

require_relative "active_view_component/components/page/head/meta/component"
require_relative "active_view_component/components/page/head/meta/props"

require_relative "active_view_component/components/page/head/component"
require_relative "active_view_component/components/page/head/props"

require_relative "active_view_component/components/page/body/component"
require_relative "active_view_component/components/page/body/props"

require_relative "active_view_component/components/page/component"
require_relative "active_view_component/components/page/props"

require_relative "generators/active_view_component/page_generator"

# Main module for the ActiveViewComponent gem
# Provides a new Rails rendering flow that persists rendered pages
# as component trees in the database
module ActiveViewComponent
  class Error < StandardError; end

  # Configuration
  mattr_accessor :enabled
  @@enabled = true

  mattr_accessor :auto_persist
  @@auto_persist = true

  def self.configure
    yield self
  end
end
