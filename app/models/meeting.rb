class Meeting < ApplicationRecord
  belongs_to :room
  belongs_to :host_by
end
