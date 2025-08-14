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

require_relative "active_view_component/core/concern/erb_parts"
require_relative "active_view_component/core/concern/view_block"
require_relative "active_view_component/core/concern/node_hier"
require_relative "active_view_component/core/concern/files"

require_relative "active_view_component/core/facet/component"
require_relative "active_view_component/core/facet/props"
require_relative "active_view_component/core/facet/style"
require_relative "active_view_component/core/facet/generator"

require_relative "active_view_component/core/view_block_node"

require_relative "active_view_component/component/page/head/meta/component"
require_relative "active_view_component/component/page/head/meta/props"
require_relative "active_view_component/component/page/head/meta/generator"

require_relative "active_view_component/component/page/head/component"
require_relative "active_view_component/component/page/head/props"
require_relative "active_view_component/component/page/head/generator"

require_relative "active_view_component/component/page/body/component"
require_relative "active_view_component/component/page/body/props"
require_relative "active_view_component/component/page/body/generator"

require_relative "active_view_component/component/page/component"
require_relative "active_view_component/component/page/props"
require_relative "active_view_component/component/page/style"
require_relative "active_view_component/component/page/generator"

require_relative "generators/active_view_component/generator"

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
