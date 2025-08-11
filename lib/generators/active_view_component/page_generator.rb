# frozen_string_literal: true

# This file is part of the ActiveViewComponent library.
module ActiveViewComponent
  class Generator
  
  # This generator is responsible for creating the default page structure
  class Page
    
    # Generates the HTML structure for the page component
    class Html
      
      # Generates the head section of the page
      class Head
        
        # Represents the head component of the page
        class Meta
        end
      
      end

      # Generates the body section of the page
      class Body
      end

      def self.generate
        ActiveViewComponent::Core::Node.new.tap do |node|
          node.component = ActiveViewComponent::Components::Page::Component.new
          node.props = ActiveViewComponent::Components::Page::Props.new
        end
      end

      # Generates a default page node structure
      def self.default_page_node
        ActiveViewComponent::Core::Node.new.tap do |node|
          node.component = ActiveViewComponent::Components::Page::Component.new
          node.props = ActiveViewComponent::Components::Page::Props.new

          node.children = [

            ActiveViewComponent::Core::Node.new.tap do |head|
              head.component = ActiveViewComponent::Components::Page::Head::Component.new
              head.props = ActiveViewComponent::Components::Page::Head::Props.new
              head.children = [

                ActiveViewComponent::Core::Node.new.tap do |meta|
                  meta.component = ActiveViewComponent::Components::Page::Head::Meta::Component.new
                  meta.props = ActiveViewComponent::Components::Page::Head::Meta::Props.new
                end

              ]
            end,

            ActiveViewComponent::Core::Node.new.tap do |body|
              body.component = ActiveViewComponent::Components::Page::Body::Component.new
              body.props = ActiveViewComponent::Components::Page::Body::Props.new
            end
          ]

          node.prepare
        end
      end
    end
  end
end
