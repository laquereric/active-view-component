# frozen_string_literal: true

# This file is part of the ActiveViewComponent library.
module ActiveViewComponent
  class Generator
    # This generator is responsible for creating the default page structure
    class Page
      class << self
        def generate(options = {})
          {}
        end

        def create_component(options = {})
          initialized_options = generate(options)
          ActiveViewComponent::Components::Page::Component.new(**initialized_options)
        end
      end

      # Generates the HTML structure for the page component
      class Html
        class << self
          def generate(options = {})
            ActiveViewComponent::Core::Concern::ViewBlockNode.new.tap do |node|
              node.component = ActiveViewComponent::Generator::Page.create_component(options)
              node.props = ActiveViewComponent::Components::Page::Props.new
            end
          end

          # Generates a default page node structure
          def default_page_node(options = {})
            page_options = options[:page] || {}
            head_options = options[:head] || {}
            meta_options = options[:meta] || {}
            body_options = options[:body] || {}

            ActiveViewComponent::Core::Concern::ViewBlockNode.new.tap do |node|
              node.component = ActiveViewComponent::Generator::Page.create_component(page_options)
              node.props = ActiveViewComponent::Components::Page::Props.new

              node.children = [

                ActiveViewComponent::Core::Concern::ViewBlockNode.new.tap do |head|
                  head.component = ActiveViewComponent::Generator::Page::Html::Head.create_component(head_options)
                  head.props = ActiveViewComponent::Components::Page::Head::Props.new
                  head.children = [
                    ActiveViewComponent::Core::Concern::ViewBlockNode.new.tap do |meta|
                      meta.component = ActiveViewComponent::Generator::Page::Html::Head::Meta.create_component(meta_options)
                      meta.props = ActiveViewComponent::Components::Page::Head::Meta::Props.new
                    end
                  ]
                end,

                ActiveViewComponent::Core::Concern::ViewBlockNode.new.tap do |body|
                  body.component = ActiveViewComponent::Generator::Page::Html::Body.create_component(body_options)
                  body.props = ActiveViewComponent::Components::Page::Body::Props.new
                end

              ]

              node.prepare
            end
          end
        end
        # Generates the head section of the page
        class Head
          class << self
            def generate(options = {})
              {
                title: options[:title] || "No Title"
              }
            end

            def create_component(options = {})
              initialized_options = generate(options)
              ActiveViewComponent::Components::Page::Head::Component.new(**initialized_options)
            end
          end

          # Represents the head component of the page
          class Meta
            class << self
              def generate(options = {})
                {
                  viewport: options[:viewport] || "width=device-width, initial-scale=1",
                  apple_mobile_web_app_capable: options[:apple_mobile_web_app_capable] || "yes",
                  mobile_web_app_capable: options[:mobile_web_app_capable] || "yes"
                }
              end

              def create_component(options = {})
                initialized_options = generate(options)
                ActiveViewComponent::Components::Page::Head::Meta::Component.new(**initialized_options)
              end
            end
          end
        end

        # Generates the body section of the page
        class Body
          class << self
            def generate(options = {})
              {}
            end

            def create_component(options = {})
              initialized_options = generate(options)
              ActiveViewComponent::Components::Page::Body::Component.new(**initialized_options)
            end
          end
        end
      end
    end
  end
end
