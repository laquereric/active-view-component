# frozen_string_literal: true

require "spec_helper"
require_relative "../lib/active-view-component"

RSpec.describe ActiveViewComponent::Core::ErbParts do
  # Create a test component class to test the concern
  let(:test_component_class) do
    Class.new do
      include ActiveViewComponent::Core::ErbParts

      erb_attr :title, type: :string, default: "Default Title"
      erb_attr :count, type: :integer
      erb_attr :visible, type: :boolean, default: true
      erb_attr :description

      erb_node :header, component_class: String
      erb_node :items, multiple: true
      erb_node :footer, default_content: "<footer>Default Footer</footer>"

      # Mock render method for testing
      def render(component)
        case component
        when String
          component
        else
          component.to_s
        end
      end
    end
  end

  let(:test_component) { test_component_class.new }

  describe "erb_attr class method" do
    it "defines getter and setter methods" do
      expect(test_component).to respond_to(:title)
      expect(test_component).to respond_to(:title=)
      expect(test_component).to respond_to(:title?)
    end

    it "applies type coercion for integer type" do
      test_component.count = "123"
      expect(test_component.count).to eq(123)
      expect(test_component.count).to be_a(Integer)
    end

    it "applies type coercion for boolean type" do
      test_component.visible = "false"
      expect(test_component.visible).to eq(true) # non-nil values are truthy

      test_component.visible = nil
      expect(test_component.visible).to be_falsey
    end

    it "applies type coercion for string type" do
      test_component.title = 12_345
      expect(test_component.title).to eq("12345")
      expect(test_component.title).to be_a(String)
    end

    it "provides question mark methods to check if attribute is set" do
      expect(test_component.title?).to be_falsey
      test_component.title = "Test Title"
      expect(test_component.title?).to be_truthy
    end

    it "stores erb attribute metadata" do
      attributes = test_component_class.erb_attributes
      expect(attributes).to have_key(:title)
      expect(attributes[:title][:type]).to eq(:string)
      expect(attributes[:title][:default]).to eq("Default Title")
    end
  end

  describe "erb_node class method" do
    it "defines getter and setter methods for single nodes" do
      expect(test_component).to respond_to(:header)
      expect(test_component).to respond_to(:header=)
      expect(test_component).to respond_to(:header?)
      expect(test_component).to respond_to(:render_header)
    end

    it "defines getter and setter methods for multiple nodes" do
      expect(test_component).to respond_to(:items)
      expect(test_component).to respond_to(:items=)
      expect(test_component).to respond_to(:items?)
      expect(test_component).to respond_to(:render_items)
      expect(test_component).to respond_to(:add_item)
    end

    it "handles single node assignment" do
      test_component.header = "Header Content"
      expect(test_component.header).to eq("Header Content")
      expect(test_component.header?).to be_truthy
    end

    it "handles multiple node assignment" do
      test_component.items = ["Item 1", "Item 2"]
      expect(test_component.items).to eq(["Item 1", "Item 2"])
      expect(test_component.items?).to be_truthy
    end

    it "supports adding individual items to multiple nodes" do
      test_component.add_item("First Item")
      test_component.add_item("Second Item")
      expect(test_component.items).to eq(["First Item", "Second Item"])
    end

    it "provides render methods for nodes" do
      test_component.header = "My Header"
      expect(test_component.render_header).to eq("My Header")
    end

    it "provides render methods for multiple nodes" do
      test_component.items = ["Item A", "Item B"]
      expect(test_component.render_items).to eq("Item AItem B")
    end

    it "uses default content when node is not set" do
      expect(test_component.render_footer).to eq("<footer>Default Footer</footer>")
    end

    it "stores erb node metadata" do
      nodes = test_component_class.erb_nodes
      expect(nodes).to have_key(:header)
      expect(nodes).to have_key(:items)
      expect(nodes[:items][:multiple]).to be_truthy
      expect(nodes[:footer][:default_content]).to eq("<footer>Default Footer</footer>")
    end
  end

  describe "class methods" do
    it "provides erb_attributes method to access metadata" do
      expect(test_component_class.erb_attributes).to be_a(Hash)
      expect(test_component_class.erb_attributes.keys).to include(:title, :count, :visible, :description)
    end

    it "provides erb_nodes method to access metadata" do
      expect(test_component_class.erb_nodes).to be_a(Hash)
      expect(test_component_class.erb_nodes.keys).to include(:header, :items, :footer)
    end
  end
end
