# frozen_string_literal: true

# This file is part of the ActiveViewComponent library.
module ActiveViewComponent
  # Page generator
  class Generator
    def self.create_view_block
      Component::Page::Generator.create_view_block(view_block_node: nil)
    end
  end
end
