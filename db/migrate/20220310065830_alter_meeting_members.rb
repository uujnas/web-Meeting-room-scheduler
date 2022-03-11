class AlterMeetingMembers < ActiveRecord::Migration[7.0]
  def change
    remove_column :meetings, :members, :text
    add_column :meetings, :members, :text, array: true, default: []
  end
end
