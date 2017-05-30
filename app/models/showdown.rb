class Showdown < ApplicationRecord
  belongs_to :winning_photo, :class_name => "Photo", :foreign_key => "winner_id"
  belongs_to :losing_photo, :class_name => "Photo", :foreign_key => "loser_id"
  has_one :winning_user, :through => :winning_photo, :source => :user
  has_one :losing_user, :through => :losing_photo, :source => :user
end
