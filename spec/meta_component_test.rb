require "test_helper"

class PageMetaComponentTest < ActiveSupport::TestCase
  test "initializes with default charset and viewport" do
    component = PageMetaComponent.new
    
    assert_equal "UTF-8", component.charset
    assert_equal "width=device-width, initial-scale=1", component.viewport
    assert_equal "index, follow", component.robots
    assert_equal "summary", component.twitter_card
  end
  
  test "accepts custom meta options" do
    options = {
      description: "Test description",
      keywords: "test, component",
      author: "Test Author",
      og_title: "Test OG Title"
    }
    
    component = PageMetaComponent.new(**options)
    
    assert_equal "Test description", component.description
    assert_equal "test, component", component.keywords
    assert_equal "Test Author", component.author
    assert_equal "Test OG Title", component.og_title
  end
  
  test "accepts custom meta tags" do
    custom_meta = { "theme-color" => "#ff0000" }
    component = PageMetaComponent.new(custom_meta: custom_meta)
    
    assert_equal custom_meta, component.custom_meta
  end
end
