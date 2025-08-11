# frozen_string_literal: true

require "spec_helper"
require_relative "../../../../../../lib/active-view-component"

RSpec.describe ActiveViewComponent::Generator::Page::Html::Head do
  describe ".generate" do
    context "with default options" do
      it "returns default configuration hash" do
        result = described_class.generate

        expect(result).to be_a(Hash)
        expect(result[:title]).to be_nil
        expect(result[:stylesheets]).to eq([])
        expect(result[:scripts]).to eq([])
        expect(result[:inline_styles]).to be_nil
        expect(result[:inline_scripts]).to be_nil
        expect(result[:meta_options]).to eq({})
      end
    end

    context "with custom options" do
      let(:custom_options) do
        {
          title: "Custom Page Title",
          stylesheets: ["/css/app.css", "/css/vendor.css"],
          scripts: ["/js/app.js"],
          inline_styles: "body { margin: 0; }",
          inline_scripts: "console.log('hello');",
          meta_options: { description: "Custom page" }
        }
      end

      it "returns configuration hash with custom values" do
        result = described_class.generate(custom_options)

        expect(result[:title]).to eq("Custom Page Title")
        expect(result[:stylesheets]).to eq(["/css/app.css", "/css/vendor.css"])
        expect(result[:scripts]).to eq(["/js/app.js"])
        expect(result[:inline_styles]).to eq("body { margin: 0; }")
        expect(result[:inline_scripts]).to eq("console.log('hello');")
        expect(result[:meta_options]).to eq({ description: "Custom page" })
      end

      it "preserves defaults for unspecified options" do
        partial_options = { title: "Partial Title", scripts: ["/js/partial.js"] }
        result = described_class.generate(partial_options)

        expect(result[:title]).to eq("Partial Title")
        expect(result[:scripts]).to eq(["/js/partial.js"])
        expect(result[:stylesheets]).to eq([]) # default value
        expect(result[:meta_options]).to eq({}) # default value
      end
    end
  end

  describe ".create_component" do
    context "with default options" do
      it "creates a Head component with default configuration" do
        component = described_class.create_component

        expect(component).to be_a(ActiveViewComponent::Components::Page::Head::Component)
        expect(component.instance_variable_get(:@title)).to be_nil
        expect(component.instance_variable_get(:@stylesheets)).to eq([])
        expect(component.instance_variable_get(:@scripts)).to eq([])
      end
    end

    context "with custom options" do
      let(:custom_options) do
        {
          title: "Test Head Title",
          stylesheets: ["/test.css"],
          meta_options: { author: "Test Author" }
        }
      end

      it "creates a Head component with custom configuration" do
        component = described_class.create_component(custom_options)

        expect(component).to be_a(ActiveViewComponent::Components::Page::Head::Component)
        expect(component.instance_variable_get(:@title)).to eq("Test Head Title")
        expect(component.instance_variable_get(:@stylesheets)).to eq(["/test.css"])
        expect(component.instance_variable_get(:@meta_options)).to eq({ author: "Test Author" })
        # Should still have defaults for unspecified options
        expect(component.instance_variable_get(:@scripts)).to eq([])
      end
    end
  end

  describe "integration with component initialization" do
    it "properly initializes component through generator" do
      options = {
        title: "Integration Head Title",
        stylesheets: ["/integration.css"],
        inline_scripts: "console.log('integration');"
      }

      component = described_class.create_component(options)

      # Verify all attributes are accessible
      expect(component.title).to eq("Integration Head Title")
      expect(component.stylesheets).to eq(["/integration.css"])
      expect(component.inline_scripts).to eq("console.log('integration');")

      # Verify defaults are still present
      expect(component.scripts).to eq([])
      expect(component.meta_options).to eq({})
    end
  end
end
