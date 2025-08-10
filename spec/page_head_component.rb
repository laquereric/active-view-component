# frozen_string_literal: true

# Head Component for managing page head section
class PageHeadComponent < SimpleComponent
  def initialize(
    title:, 
    meta_options: {},
    stylesheets: [], 
    scripts: [],
    inline_styles: nil,
    inline_scripts: nil
  )
    super(
      title: title,
      meta_options: meta_options,
      stylesheets: stylesheets,
      scripts: scripts,
      inline_styles: inline_styles,
      inline_scripts: inline_scripts
    )
  end
end
