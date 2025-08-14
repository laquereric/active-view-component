module ActiveViewComponent
  module Component
    module Page
      module Body
        class Props
          attr_accessor :body_class, :data_attributes, :content, :total_users, :online_users, :offline_users,
                        :total_rooms, :recent_activity, :active_rooms, :popular_rooms, :recent_users
          #           def initialize(body_class: nil, data_attributes: {})
          #             @body_class = body_class
          #             @data_attributes = data_attributes
          #             @content = nil
          #             @total_users = total_users
          #             @online_users = online_users
          #             @offline_users = offline_users
          #             @total_rooms = total_rooms
          #             @recent_activity = recent_activity
          #             @active_rooms = active_rooms
          #             @popular_rooms = popular_rooms
          #             @recent_users = recent_users
          #           end
        end
      end
    end
  end
end
