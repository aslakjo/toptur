require 'json/add/rails'

class Tour < ActiveRecord::Base
  belongs_to :user
  has_many :paths
  validates_presence_of :user, :title, :body


  def upPath
    paths.find_by_name("up")
  end

  def downPath
    paths.find_by_name("down")
  end

  def pointsGoingUp=(value)
    
    upPath = self.upPath
    if(!upPath)
      upPath = Path.create(:tour_id => :this, :name => "up")
      paths << upPath
    end
    upPath.points.clear

    JSON.parse(value).each do |point|
      if(point.length > 1)
        upPath.points << Point.create(:lat => point[0].to_s, :lng => point[1].to_s)       
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
    downPath = self.downPath
    if(!downPath)
      downPath = Path.create(:tour_id => :this, :name =>"down")
      paths << downPath
    end
    
    downPath.points.clear

    JSON.parse(value).each do |point|
      if(point.length > 1)
        downPath.points << Point.create(:lat => point[0].to_s, :lng => point[1].to_s)

      end
    end
    puts downPath.inspect
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
