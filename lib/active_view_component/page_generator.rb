
module ActiveViewComponent
  class PageGenerator
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
