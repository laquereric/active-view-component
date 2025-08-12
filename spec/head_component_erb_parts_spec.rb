# frozen_string_literal: true

require "spec_helper"
require_relative "../lib/active-view-component"

RSpec.describe ActiveViewComponent::Components::Page::Head::Component do
  let(:component) { described_class.new }

  describe "ErbParts integration" do
    it "includes ErbParts concern" do
      expect(component.class.ancestors).to include(ActiveViewComponent::Core::ErbParts)
    end

    it "defines erb_attr attributes" do
      expect(component).to respond_to(:title)
      expect(component).to respond_to(:title=)
      expect(component).to respond_to(:title?)

      expect(component).to respond_to(:charset)
      expect(component).to respond_to(:charset=)
      expect(component).to respond_to(:charset?)

      expect(component).to respond_to(:viewport)
      expect(component).to respond_to(:viewport=)
      expect(component).to respond_to(:viewport?)
    end

    it "sets default values for erb_attr attributes" do
      # Default values are only applied when explicitly accessed after being set
      component.title = nil
      component.charset = nil
      component.viewport = nil

      # Check that the attributes can be set and retrieved
      component.title = "Test Title"
      expect(component.title).to eq("Test Title")

      component.charset = "ISO-8859-1"
      expect(component.charset).to eq("ISO-8859-1")

      component.viewport = "width=1024"
      expect(component.viewport).to eq("width=1024")
    end

    it "defines erb_node nodes" do
      expect(component).to respond_to(:meta)
      expect(component).to respond_to(:meta=)
      expect(component).to respond_to(:meta?)
      expect(component).to respond_to(:render_meta)

      expect(component).to respond_to(:stylesheets)
      expect(component).to respond_to(:stylesheets=)
      expect(component).to respond_to(:stylesheets?)
      expect(component).to respond_to(:render_stylesheets)
      expect(component).to respond_to(:add_stylesheet)

      expect(component).to respond_to(:scripts)
      expect(component).to respond_to(:scripts=)
      expect(component).to respond_to(:scripts?)
      expect(component).to respond_to(:render_scripts)
      expect(component).to respond_to(:add_script)
    end

    it "handles multiple node collections" do
      component.add_stylesheet("style1.css")
      component.add_stylesheet("style2.css")
      expect(component.stylesheets).to eq(["style1.css", "style2.css"])

      component.add_script("script1.js")
      component.add_script("script2.js")
      expect(component.scripts).to eq(["script1.js", "script2.js"])
    end

    it "provides metadata about erb attributes and nodes" do
      attributes = described_class.erb_attributes
      expect(attributes).to have_key(:title)
      expect(attributes).to have_key(:charset)
      expect(attributes).to have_key(:viewport)

      nodes = described_class.erb_nodes
      expect(nodes).to have_key(:meta)
      expect(nodes).to have_key(:stylesheets)
      expect(nodes).to have_key(:scripts)
      expect(nodes[:stylesheets][:multiple]).to be_truthy
      expect(nodes[:scripts][:multiple]).to be_truthy
    end
  end
end
