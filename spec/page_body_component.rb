# frozen_string_literal: true

# Body Component for managing page body wrapper
class PageBodyComponent < SimpleComponent
  def initialize(body_class: nil, data_attributes: {})
    super(
      body_class: body_class,
      data_attributes: data_attributes
    )
  end
end
