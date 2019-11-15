# frozen_string_literal: true

module TimeHelper
  def human_readable_time(timestamp)
    timestamp.in_time_zone('Mountain Time (US & Canada)').strftime('%b %e, %l:%M %p')
  end
end
