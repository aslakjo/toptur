class Tour < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :user, :title, :body

end
