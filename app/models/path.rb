class Path < ActiveRecord::Base
  belongs_to  :tour
  has_many    :points

  validates_inclusion_of(:name, :in => %w( up down ))

  def empty?
    points.empty?
  end

  def to_array
    array =[]
    points.each do |point|
      array << [point.lat, point.lng]
    end
    array
  end

end
