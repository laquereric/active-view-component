# frozen_string_literal: true

require "rails/generators"
require "rails/generators/migration"

module ActiveViewComponent
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      
      #source_root File.expand_path("templates", __dir__)
      
      #def self.next_migration_number(path)
      #  Time.now.utc.strftime("%Y%m%d%H%M%S")
      #end
      
      #def create_migration
      #  migration_template "create_active_view_components.rb", 
      #                    "db/migrate/create_active_view_components.rb"
      #end
      
      #def create_initializer
      #  template "initializer.rb", "config/initializers/active_view_component.rb"
      #end
    end
  end
end
