class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :photos, :dependent => :destroy
  has_many :showdowns_as_winner, :through => :photos, :source => :showdowns_as_winner
  has_many :showdowns_as_loser, :through => :photos, :source => :showdowns_as_loser
end
