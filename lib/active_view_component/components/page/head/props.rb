# frozen_string_literal: true
module ActiveViewComponent
class Page::Head::Props
  attr_accessor :title

  # Initializes the head properties for the page component
  def initialize(title:)
    @title = title
  end
end
end