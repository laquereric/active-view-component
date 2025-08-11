# frozen_string_literal: true

require "component_helper"

RSpec.describe ActiveViewComponent::Components::Page::Head::Component, type: :component do
  let(:title) { "Test Title" }

  describe "basic rendering" do
    it "renders head with title" do
      render_inline(ActiveViewComponent::Components::Page::Head::Component.new(title: title))

      expect(page).to have_selector("head")
      expect(page).to have_selector("title", text: title)
    end
  end

  describe "with stylesheets and scripts" do
    let(:stylesheets) { ["/assets/app.css", "/assets/vendor.css"] }
    let(:scripts) { ["/assets/app.js"] }

    it "includes external resources" do
      render_inline(ActiveViewComponent::Components::Page::Head::Component.new(
                      title: title,
                      stylesheets: stylesheets,
                      scripts: scripts
                    ))

      expect(page).to have_selector('link[rel="stylesheet"][href="/assets/app.css"]', visible: false)
      expect(page).to have_selector('link[rel="stylesheet"][href="/assets/vendor.css"]', visible: false)
      expect(page).to have_selector('script[src="/assets/app.js"]', visible: false)
    end
  end

  describe "with inline styles and scripts" do
    let(:inline_styles) { "body { background: red; }" }
    let(:inline_scripts) { "alert('test');" }

    it "includes inline content" do
      render_inline(ActiveViewComponent::Components::Page::Head::Component.new(
                      title: title,
                      inline_styles: inline_styles,
                      inline_scripts: inline_scripts
                    ))

      expect(page).to have_selector("style", text: inline_styles, visible: false)
      expect(page).to have_selector("script", text: inline_scripts, visible: false)
    end
  end

  describe "with meta options" do
    let(:meta_options) { { description: "Test page" } }

    it "renders meta component with options" do
      render_inline(ActiveViewComponent::Components::Page::Head::Component.new(
                      title: title,
                      meta_options: meta_options
                    ))

      expect(page).to have_selector('meta[name="description"][content="Test page"]', visible: false)
    end
  end
end
