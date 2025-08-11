# frozen_string_literal: true

require "spec_helper"
require_relative "../../../../lib/active-view-component"

RSpec.describe ActiveViewComponent::Generator::Page do
  describe ".generate" do
    context "with default options" do
      it "returns default configuration hash" do
        result = described_class.generate

        expect(result).to be_a(Hash)
        expect(result[:title]).to be_nil
        expect(result[:body_class]).to be_nil
        expect(result[:lang]).to eq("en")
        expect(result[:dir]).to eq("ltr")
        expect(result[:meta_options]).to eq({})
        expect(result[:html_attributes]).to eq({})
        expect(result[:data_attributes]).to eq({})
        expect(result[:show_header]).to eq(true)
      end
    end

    context "with custom options" do
      let(:custom_options) do
        {
          title: "Custom Page Title",
          body_class: "custom-body",
          lang: "es",
          dir: "rtl",
          meta_options: { description: "Custom description" },
          html_attributes: { "data-theme" => "dark" },
          data_attributes: { "controller" => "page" },
          show_header: false
        }
      end

      it "returns configuration hash with custom values" do
        result = described_class.generate(custom_options)

        expect(result[:title]).to eq("Custom Page Title")
        expect(result[:body_class]).to eq("custom-body")
        expect(result[:lang]).to eq("es")
        expect(result[:dir]).to eq("rtl")
        expect(result[:meta_options]).to eq({ description: "Custom description" })
        expect(result[:html_attributes]).to eq({ "data-theme" => "dark" })
        expect(result[:data_attributes]).to eq({ "controller" => "page" })
        expect(result[:show_header]).to eq(false)
      end

      it "preserves defaults for unspecified options" do
        partial_options = { title: "Partial Title", lang: "fr" }
        result = described_class.generate(partial_options)

        expect(result[:title]).to eq("Partial Title")
        expect(result[:lang]).to eq("fr")
        expect(result[:dir]).to eq("ltr") # default value
        expect(result[:show_header]).to eq(true) # default value
      end
    end

    context "with show_header explicitly set to false" do
      it "respects false value for show_header" do
        result = described_class.generate(show_header: false)
        expect(result[:show_header]).to eq(false)
      end
    end
  end

  describe ".create_component" do
    context "with default options" do
      it "creates a Page component with default configuration" do
        component = described_class.create_component

        expect(component).to be_a(ActiveViewComponent::Components::Page::Component)
        expect(component.instance_variable_get(:@title)).to be_nil
        expect(component.instance_variable_get(:@lang)).to eq("en")
        expect(component.instance_variable_get(:@dir)).to eq("ltr")
        expect(component.instance_variable_get(:@show_header)).to eq(true)
      end
    end

    context "with custom options" do
      let(:custom_options) do
        {
          title: "Test Page Title",
          body_class: "test-page",
          lang: "de",
          html_attributes: { "data-app" => "true" }
        }
      end

      it "creates a Page component with custom configuration" do
        component = described_class.create_component(custom_options)

        expect(component).to be_a(ActiveViewComponent::Components::Page::Component)
        expect(component.instance_variable_get(:@title)).to eq("Test Page Title")
        expect(component.instance_variable_get(:@body_class)).to eq("test-page")
        expect(component.instance_variable_get(:@lang)).to eq("de")
        expect(component.instance_variable_get(:@html_attributes)).to eq({ "data-app" => "true" })
        # Should still have defaults for unspecified options
        expect(component.instance_variable_get(:@dir)).to eq("ltr")
      end
    end
  end

  describe "integration with component initialization" do
    it "properly initializes component through generator" do
      options = {
        title: "Integration Page Title",
        body_class: "integration-page",
        meta_options: { description: "Integration test", keywords: "test, page" },
        show_header: false
      }

      component = described_class.create_component(options)

      # Verify all attributes are accessible
      expect(component.title).to eq("Integration Page Title")
      expect(component.body_class).to eq("integration-page")
      expect(component.meta_options).to eq({ description: "Integration test", keywords: "test, page" })
      expect(component.show_header).to eq(false)

      # Verify defaults are still present
      expect(component.lang).to eq("en")
      expect(component.dir).to eq("ltr")
      expect(component.html_attributes).to eq({})
      expect(component.data_attributes).to eq({})
    end
  end
end
