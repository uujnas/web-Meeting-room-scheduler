class AddMeetingUrlToMeeting < ActiveRecord::Migration[7.0]
  def change
    add_column :meetings, :meeting_url, :string
  end
end
