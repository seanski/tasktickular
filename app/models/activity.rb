class Activity < ActiveRecord::Base
  belongs_to :user
  attr_accessible :did_at, :origin, :summary, :time_spent_in_minutes
end
