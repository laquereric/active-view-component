# frozen_string_literal: true

require "rails"
require "ancestry"
require "view_component"

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



#require_relative "active_view_component/renderer"
#require_relative "active_view_component/tree_builder"
#require_relative "active_view_component/controller_extensions"
#require_relative "active_view_component/view_helpers"

module ActiveViewComponent
  # Main module for the ActiveViewComponent gem
  # Provides a new Rails rendering flow that persists rendered pages
  # as component trees in the database
  
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
