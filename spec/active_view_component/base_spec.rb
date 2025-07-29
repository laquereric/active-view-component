# frozen_string_literal: true

require "spec_helper"

RSpec.describe ActiveViewComponent::Base do
  # This is a minimal test since we can't run full ActiveRecord without Rails
  it "defines the correct table name" do
    expect(ActiveViewComponent::Base.table_name).to eq("active_view_components")
  end
  
  it "has the expected class structure" do
    # Check that the methods are defined at class level
    expect(ActiveViewComponent::Base).to respond_to(:create_from_component)
    
    # Check instance methods we defined
    expect(ActiveViewComponent::Base.instance_methods).to include(:component_class)
    expect(ActiveViewComponent::Base.instance_methods).to include(:instantiate_component)
    expect(ActiveViewComponent::Base.instance_methods).to include(:render_component)
  end
end
