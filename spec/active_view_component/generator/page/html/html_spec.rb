# frozen_string_literal: true

require "spec_helper"
require_relative "../../../../../lib/active-view-component"

RSpec.describe ActiveViewComponent::Generator::Page::Html do
  describe ".generate" do
    context "with default options" do
      it "creates a basic node structure" do
        node = described_class.generate

        expect(node).to be_a(ActiveViewComponent::Core::Node)
        expect(node.component).to be_a(ActiveViewComponent::Components::Page::Component)
        expect(node.props).to be_a(ActiveViewComponent::Components::Page::Props)
      end
    end

    context "with custom page options" do
      let(:custom_options) do
        {
          title: "Generated Page",
          lang: "es",
          body_class: "generated-page"
        }
      end

      it "creates node with custom page component" do
        node = described_class.generate(custom_options)

        expect(node).to be_a(ActiveViewComponent::Core::Node)
        expect(node.component).to be_a(ActiveViewComponent::Components::Page::Component)
        expect(node.component.title).to eq("Generated Page")
        expect(node.component.lang).to eq("es")
        expect(node.component.body_class).to eq("generated-page")
      end
    end
  end

  describe ".default_page_node" do
    context "with default options" do
      it "creates a complete page structure with all components" do
        node = described_class.default_page_node

        expect(node).to be_a(ActiveViewComponent::Core::Node)
        expect(node.component).to be_a(ActiveViewComponent::Components::Page::Component)
        expect(node.children).to have(2).items

        # Check head component
        head_node = node.children[0]
        expect(head_node.component).to be_a(ActiveViewComponent::Components::Page::Head::Component)
        expect(head_node.children).to have(1).item

        # Check meta component within head
        meta_node = head_node.children[0]
        expect(meta_node.component).to be_a(ActiveViewComponent::Components::Page::Head::Meta::Component)

        # Check body component
        body_node = node.children[1]
        expect(body_node.component).to be_a(ActiveViewComponent::Components::Page::Body::Component)
      end
    end

    context "with custom options for each component" do
      let(:custom_options) do
        {
          page: { title: "Custom Page", lang: "fr" },
          head: { title: "Custom Head Title", stylesheets: ["/custom.css"] },
          meta: { description: "Custom meta description", author: "Custom Author" },
          body: { body_class: "custom-body", data_attributes: { "theme" => "dark" } }
        }
      end

      it "creates page structure with custom component configurations" do
        node = described_class.default_page_node(custom_options)

        # Check page component
        expect(node.component.title).to eq("Custom Page")
        expect(node.component.lang).to eq("fr")

        # Check head component
        head_node = node.children[0]
        expect(head_node.component.title).to eq("Custom Head Title")
        expect(head_node.component.stylesheets).to eq(["/custom.css"])

        # Check meta component
        meta_node = head_node.children[0]
        expect(meta_node.component.description).to eq("Custom meta description")
        expect(meta_node.component.author).to eq("Custom Author")

        # Check body component
        body_node = node.children[1]
        expect(body_node.component.body_class).to eq("custom-body")
        expect(body_node.component.data_attributes).to eq({ "theme" => "dark" })
      end
    end

    context "with partial options" do
      let(:partial_options) do
        {
          page: { title: "Partial Page" },
          meta: { description: "Partial meta" }
        }
      end

      it "applies custom options while preserving defaults" do
        node = described_class.default_page_node(partial_options)

        # Custom options should be applied
        expect(node.component.title).to eq("Partial Page")

        meta_node = node.children[0].children[0]
        expect(meta_node.component.description).to eq("Partial meta")

        # Defaults should be preserved
        expect(node.component.lang).to eq("en")
        expect(meta_node.component.charset).to eq("UTF-8")
      end
    end

    it "calls prepare on the node" do
      # This test ensures the node structure is properly prepared
      node = described_class.default_page_node

      # If prepare was called, the component should have children set
      expect(node.children).not_to be_empty
      expect(node.children[0].children).not_to be_empty
    end
  end
end
