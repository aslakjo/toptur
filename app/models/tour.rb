class Tour < ActiveRecord::Base
  belongs_to :user
  has_many :paths
  validates_presence_of :user, :title, :body

  def pointsGoingUp
    paths.each do |path|
      if path.name == "up"
        return path.points
      end
    end
    return []
  end


  def pointsGoingDown
    paths.each do |path|
      if path.name == "down"
        return path.points
      end
    end
    return []
  end
end
