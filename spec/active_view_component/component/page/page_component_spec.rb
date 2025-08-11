# frozen_string_literal: true

require "component_helper"

RSpec.describe ActiveViewComponent::Components::Page::Component, type: :component do
  describe "rendering" do
    it "renders a complete page component with content" do
      render_inline(ActiveViewComponent::Components::Page::Component.new) { "Hello, world!" }

      expect(page).to have_content("Hello, world!")
    end

    it "renders with custom parameters" do
      render_inline(ActiveViewComponent::Components::Page::Component.new(title: "Custom Title")) { "Content" }

      expect(page).to have_content("Content")
    end

    it "handles basic rendering" do
      render_inline(ActiveViewComponent::Components::Page::Component.new(body_class: "test-class")) { "Content" }

      expect(page).to have_content("Content")
    end

    it "renders with language attributes" do
      render_inline(ActiveViewComponent::Components::Page::Component.new(lang: "es", dir: "rtl")) { "Content" }

      expect(page).to have_content("Content")
    end
  end

  describe "with component options" do
    it "renders with meta options" do
      meta_options = {
        description: "Test description",
        keywords: "test, keywords",
        og_title: "OG Title",
        og_description: "OG Description"
      }

      render_inline(ActiveViewComponent::Components::Page::Component.new(meta_options: meta_options)) { "Content" }

      expect(page).to have_content("Content")
    end

    it "renders with custom attributes" do
      html_attributes = { "data-theme" => "dark", "class" => "no-js" }
      render_inline(ActiveViewComponent::Components::Page::Component.new(html_attributes: html_attributes)) { "Content" }

      expect(page).to have_content("Content")
    end

    it "renders with data attributes" do
      data_attributes = { "controller" => "page", "action" => "show" }
      render_inline(ActiveViewComponent::Components::Page::Component.new(data_attributes: data_attributes)) { "Content" }

      expect(page).to have_content("Content")
    end

    it "handles header visibility options" do
      render_inline(ActiveViewComponent::Components::Page::Component.new(show_header: true)) { "Content" }

      expect(page).to have_content("Content")
    end

    it "handles header hidden state" do
      render_inline(ActiveViewComponent::Components::Page::Component.new(show_header: false)) { "Content" }

      expect(page).to have_content("Content")
    end

    it "handles basic component rendering" do
      render_inline(ActiveViewComponent::Components::Page::Component.new) { "Content" }

      expect(page).to have_content("Content")
    end
  end
end
