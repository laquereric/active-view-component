# frozen_string_literal: true

require "spec_helper"
require_relative "../../../../../../../lib/active-view-component"

RSpec.describe ActiveViewComponent::Generator::Page::Html::Head::Meta do
  describe ".generate" do
    context "with default options" do
      it "returns default configuration hash" do
        result = described_class.generate

        expect(result).to be_a(Hash)
        expect(result[:description]).to eq("Desc")
        expect(result[:author]).to eq("me")
        expect(result[:charset]).to eq("UTF-8")
        expect(result[:viewport]).to eq("width=device-width, initial-scale=1")
        expect(result[:robots]).to eq("index, follow")
        expect(result[:twitter_card]).to eq("summary")
        expect(result[:custom_meta]).to eq({})
        expect(result[:keywords]).to be_nil
        expect(result[:og_title]).to be_nil
        expect(result[:og_description]).to be_nil
      end
    end

    context "with custom options" do
      let(:custom_options) do
        {
          description: "Custom description",
          author: "Custom Author",
          charset: "UTF-16",
          viewport: "width=1200",
          robots: "noindex, nofollow",
          twitter_card: "summary_large_image",
          custom_meta: { "theme-color" => "#ff0000" },
          keywords: "test, custom",
          og_title: "Custom OG Title",
          og_description: "Custom OG Description"
        }
      end

      it "returns configuration hash with custom values" do
        result = described_class.generate(custom_options)

        expect(result[:description]).to eq("Custom description")
        expect(result[:author]).to eq("Custom Author")
        expect(result[:charset]).to eq("UTF-16")
        expect(result[:viewport]).to eq("width=1200")
        expect(result[:robots]).to eq("noindex, nofollow")
        expect(result[:twitter_card]).to eq("summary_large_image")
        expect(result[:custom_meta]).to eq({ "theme-color" => "#ff0000" })
        expect(result[:keywords]).to eq("test, custom")
        expect(result[:og_title]).to eq("Custom OG Title")
        expect(result[:og_description]).to eq("Custom OG Description")
      end

      it "preserves defaults for unspecified options" do
        partial_options = { description: "Partial custom", keywords: "partial" }
        result = described_class.generate(partial_options)

        expect(result[:description]).to eq("Partial custom")
        expect(result[:keywords]).to eq("partial")
        expect(result[:author]).to eq("me") # default value
        expect(result[:charset]).to eq("UTF-8") # default value
      end
    end
  end

  describe ".create_component" do
    context "with default options" do
      it "creates a Meta component with default configuration" do
        component = described_class.create_component

        expect(component).to be_a(ActiveViewComponent::Components::Page::Head::Meta::Component)
        expect(component.instance_variable_get(:@description)).to eq("Desc")
        expect(component.instance_variable_get(:@author)).to eq("me")
        expect(component.instance_variable_get(:@charset)).to eq("UTF-8")
      end
    end

    context "with custom options" do
      let(:custom_options) do
        {
          description: "Test Description",
          author: "Test Author",
          keywords: "test, spec"
        }
      end

      it "creates a Meta component with custom configuration" do
        component = described_class.create_component(custom_options)

        expect(component).to be_a(ActiveViewComponent::Components::Page::Head::Meta::Component)
        expect(component.instance_variable_get(:@description)).to eq("Test Description")
        expect(component.instance_variable_get(:@author)).to eq("Test Author")
        expect(component.instance_variable_get(:@keywords)).to eq("test, spec")
        # Should still have defaults for unspecified options
        expect(component.instance_variable_get(:@charset)).to eq("UTF-8")
      end
    end
  end

  describe "integration with component initialization" do
    it "properly initializes component through generator" do
      options = {
        description: "Integration test",
        og_title: "Integration OG Title",
        custom_meta: { "test-meta" => "test-value" }
      }

      component = described_class.create_component(options)
      
      # Verify all attributes are accessible
      expect(component.description).to eq("Integration test")
      expect(component.og_title).to eq("Integration OG Title")
      expect(component.custom_meta).to eq({ "test-meta" => "test-value" })
      
      # Verify defaults are still present
      expect(component.charset).to eq("UTF-8")
      expect(component.robots).to eq("index, follow")
    end
  end
end
