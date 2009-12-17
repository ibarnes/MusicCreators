class Topic < ActiveRecord::Base

  validates_presence_of     :topic_id, :text, :subject
  validates_length_of       :subject, :within => 1..50
  validates_length_of       :question, :within => 1..200

  belongs_to :question
  
end
