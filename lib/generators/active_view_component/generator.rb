# frozen_string_literal: true

# This file is part of the ActiveViewComponent library.
module ActiveViewComponent
  # Generator is a little different than the standard view_blockgenerator.
  # Its the entry point for root view_block (Component::Page::Generator) which in turn create child view_blocks
  class Generator
    attr_accessor :file
    
    def self.create_page_component_with(generator_klass: Component::Page::Generator)
      p "#{self} calling setup_root on #{generator_klass}"
      generator_klass.new.setup_root.view_block.component
    end

    def initialize
      set_generator_file
    end

    def set_generator_file
      @generator_file = __FILE__
      self
    end

  end
end
