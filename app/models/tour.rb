require 'json/add/rails'

class Tour < ActiveRecord::Base
  belongs_to :user
  has_many :paths
  validates_presence_of :user, :title, :body


  def pointsGoingUp=(value)
    upPath = paths(:name => "up")[0]
    if(!upPath)
      upPath = Path.new :tour => this
    end
    upPath.points.clear

    JSON.parse(value).each do |point|
      if(point.length > 1)
        upPath.points << Point.new(:lat => point[0].to_s, :lng => point[0].to_s)
      end
    end

    upPath.save!
  end

  def pointsGoingUp
    paths.each do |path|
      if path.name == "up"
        json = "["
        path.points.each do |point|
          json += "[" +point.lat + "," + point.lng + "],"
        end
        return json + "[]]"
      end
    end
    return []
  end


  def pointsGoingDown=(value)
    downPath = paths(:name => "down")[0]
    if(downPath == nil)
      downPath = Path.create :tour => this
    end
    
    downPath.points.clear

    JSON.parse(value).each do |point|
      if(point.length > 1)
        downPath.points << Point.create(:lat => point[0].to_s, :lng => point[0].to_s, :path => downPath)

      end
    end
    
    downPath.save!
  end

  def pointsGoingDown
    paths.each do |path|
      if path.name == "down"
        json = "["
        path.points.each do |point|
          json += "[" +point.lat + "," + point.lng + "],"
        end
        return json + "[]]"
      end
      
    end
    return []
  end

end
