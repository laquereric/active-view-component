# frozen_string_literal: true

# Example Page Component
class PageComponent < ViewComponent::Base
  def initialize(title:, body_class: nil)
    @title = title
    @body_class = body_class
  end
  
  private
  
  attr_reader :title, :body_class
end
