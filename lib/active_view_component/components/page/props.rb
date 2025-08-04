module ActiveViewComponent
class Page::Props
  attr_accessor :total_users, :online_users, :offline_users, :total_rooms, :recent_activity, :active_rooms, :popular_rooms, :recent_users

  def initialize(base_props: @base_props, total_users:, online_users:, offline_users:, total_rooms:, recent_activity:, active_rooms:, popular_rooms:, recent_users:)
    @base_props = base_props
    @total_users = total_users
    @online_users = online_users
    @offline_users = offline_users
    @total_rooms = total_rooms
    @recent_activity = recent_activity
    @active_rooms = active_rooms
    @popular_rooms = popular_rooms
    @recent_users = recent_users
  end
end
end