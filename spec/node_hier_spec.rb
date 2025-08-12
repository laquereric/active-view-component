# frozen_string_literal: true

require "spec_helper"

# Create test classes to test the concern
class TestComponent
  include ActiveViewComponent::Core::Concern::NodeHier

  attr_reader :name

  def initialize(name = :test)
    @name = name
  end
end

class TestChild
  include ActiveViewComponent::Core::Concern::NodeHier

  attr_reader :name

  def initialize(name = :child)
    @name = name
  end
end

RSpec.describe ActiveViewComponent::Core::Concern::NodeHier do
  let(:component) { TestComponent.new(:parent) }
  let(:child1) { TestChild.new(:child1) }
  let(:child2) { TestChild.new(:child2) }

  describe "attributes" do
    it "provides parent attribute" do
      expect(component).to respond_to(:parent)
      expect(component).to respond_to(:parent=)
    end

    it "provides children attribute" do
      expect(component).to respond_to(:children)
      expect(component).to respond_to(:children=)
    end
  end

  describe "#prepare" do
    it "sets the parent when provided" do
      parent_component = TestComponent.new(:grandparent)
      component.prepare(parent: parent_component)
      expect(component.parent).to eq(parent_component)
    end

    it "initializes children as empty array" do
      component.prepare
      expect(component.children).to eq([])
    end

    it "calls prepare on children that respond to it" do
      component.children = [child1, child2]
      expect(child1).to receive(:prepare).with(parent: component)
      expect(child2).to receive(:prepare).with(parent: component)
      component.prepare
    end
  end

  describe "#prepare_children" do
    it "initializes children as empty array if nil" do
      component.prepare_children
      expect(component.children).to eq([])
    end

    it "calls prepare on each child" do
      component.children = [child1, child2]
      expect(child1).to receive(:prepare).with(parent: component)
      expect(child2).to receive(:prepare).with(parent: component)
      component.prepare_children
    end
  end

  describe "#child_named" do
    before do
      component.children = [child1, child2]
    end

    it "finds child by name" do
      expect(component.child_named(:child1)).to eq(child1)
    end

    it "returns nil for non-existent child" do
      expect(component.child_named(:nonexistent)).to be_nil
    end

    it "handles nil children gracefully" do
      component.children = nil
      expect(component.child_named(:anything)).to be_nil
    end
  end

  describe "#add_child" do
    it "adds child to children array" do
      component.add_child(child1)
      expect(component.children).to include(child1)
    end

    it "sets parent on the child" do
      component.add_child(child1)
      expect(child1.parent).to eq(component)
    end

    it "initializes children array if nil" do
      component.children = nil
      component.add_child(child1)
      expect(component.children).to eq([child1])
    end
  end

  describe "#remove_child" do
    before do
      component.add_child(child1)
      component.add_child(child2)
    end

    it "removes child from children array" do
      component.remove_child(child1)
      expect(component.children).not_to include(child1)
      expect(component.children).to include(child2)
    end

    it "sets parent to nil on removed child" do
      component.remove_child(child1)
      expect(child1.parent).to be_nil
    end
  end

  describe "#has_children?" do
    it "returns false when no children" do
      expect(component.has_children?).to be false
    end

    it "returns false when children array is empty" do
      component.children = []
      expect(component.has_children?).to be false
    end

    it "returns true when has children" do
      component.add_child(child1)
      expect(component.has_children?).to be true
    end
  end

  describe "#descendants" do
    it "returns empty array when no children" do
      expect(component.descendants).to eq([])
    end

    it "returns direct children" do
      component.add_child(child1)
      component.add_child(child2)
      expect(component.descendants).to match_array([child1, child2])
    end

    it "returns nested descendants" do
      grandchild = TestChild.new(:grandchild)
      child1.add_child(grandchild)
      component.add_child(child1)
      component.add_child(child2)

      expect(component.descendants).to match_array([child1, child2, grandchild])
    end
  end
end
