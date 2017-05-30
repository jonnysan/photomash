class Photo < ApplicationRecord
  has_many :showdowns_as_winner, :class_name => "Showdown", :foreign_key => "winner_id", :dependent => :destroy
  has_many :showdowns_as_loser, :class_name => "Showdown", :foreign_key => "loser_id", :dependent => :destroy
  belongs_to :user
end
