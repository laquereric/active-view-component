# frozen_string_literal: true

# Example Header Component
class HeaderComponent < ViewComponent::Base
  def initialize(title:, navigation_items: [])
    @title = title
    @navigation_items = navigation_items
  end
  
  private
  
  attr_reader :title, :navigation_items
end
