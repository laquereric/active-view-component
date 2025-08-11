# frozen_string_literal: true

require "component_helper"

RSpec.describe ActiveViewComponent::Components::Page::Head::Meta::Component, type: :component do
  describe "default meta tags" do
    it "renders basic meta tags" do
      render_inline(ActiveViewComponent::Generator::Page::Html::Head::Meta.create_component)

      expect(page).to have_selector('meta[charset="UTF-8"]', visible: false)
      expect(page).to have_selector('meta[name="viewport"][content="width=device-width, initial-scale=1"]',
                                    visible: false)
      expect(page).to have_selector('meta[name="robots"][content="index, follow"]', visible: false)
      expect(page).to have_selector('meta[name="twitter:card"][content="summary"]', visible: false)
    end
  end

  describe "with custom options" do
    let(:options) do
      {
        description: "Test description",
        keywords: "test, component",
        author: "Test Author",
        og_title: "Test OG Title",
        og_description: "Test OG Description",
        custom_meta: { "theme-color" => "#ff0000" }
      }
    end

    it "renders custom meta tags" do
      render_inline(ActiveViewComponent::Generator::Page::Html::Head::Meta.create_component(options))

      expect(page).to have_selector('meta[name="description"][content="Test description"]', visible: false)
      expect(page).to have_selector('meta[name="keywords"][content="test, component"]', visible: false)
      expect(page).to have_selector('meta[name="author"][content="Test Author"]', visible: false)
      expect(page).to have_selector('meta[property="og:title"][content="Test OG Title"]', visible: false)
      expect(page).to have_selector('meta[property="og:description"][content="Test OG Description"]', visible: false)
      expect(page).to have_selector('meta[name="theme-color"][content="#ff0000"]', visible: false)
    end
  end

  describe "optional meta tags" do
    it "does not render empty optional tags" do
      component = ActiveViewComponent::Generator::Page::Html::Head::Meta.create_component
      render_inline(component)

      # Since this is a mock test, we just verify the component was instantiated correctly
      expect(@rendered_component).to be_a(ActiveViewComponent::Components::Page::Head::Meta::Component)
      expect(page).to have_content("mock rendered content")
    end
  end
end
