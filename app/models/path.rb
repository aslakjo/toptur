class Path < ActiveRecord::Base
  belongs_to  :tour
  has_many    :points

  validates_inclusion_of(:name, :in => %w( up down ))

end
