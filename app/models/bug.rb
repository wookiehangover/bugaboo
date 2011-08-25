class Bug < ActiveRecord::Base

  belongs_to :project
  belongs_to :author, :class_name => 'User', :foreign_key => 'author_id'

  validates :summary, :author_id, :current_state, :severity, :project_id, :presence => true

  STATES = %w(Open Closed)
  SEVERITIES = ["Meh", "Pretty bad", "Sound the alarm"]
end
