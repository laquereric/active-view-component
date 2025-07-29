# frozen_string_literal: true

require_relative "lib/active_view_component/version"

Gem::Specification.new do |spec|
  spec.name = "active-view-component"
  spec.version = ActiveViewComponent::VERSION
  spec.authors = ["Eric Laquer"]
  spec.email = ["laquereric@gmail.com"]

  spec.summary = "A new Rails rendering flow that persists rendered pages as component trees"
  spec.description = "ActiveViewComponent implements a new Rails rendering flow where every rendered page is persisted to the database as a tree of components using the ancestry gem. Each component inherits from ActiveRecord and has schema support."
  spec.homepage = "https://github.com/ericlaquer/active-view-component"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ericlaquer/active-view-component"
  spec.metadata["changelog_uri"] = "https://github.com/ericlaquer/active-view-component/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ Gemfile .gitignore .rspec spec/ .github/ .rubocop.yml])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Dependencies
  spec.add_dependency "rails", ">= 7.0.0"
  spec.add_dependency "ancestry", "~> 4.0"
  spec.add_dependency "view_component", "~> 3.0"

  # Development dependencies
  spec.add_development_dependency "rspec-rails", "~> 6.0"
  spec.add_development_dependency "sqlite3", "~> 1.4"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
