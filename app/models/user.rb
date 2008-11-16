class User < ActiveRecord::Base
  has_many :tours

  validates_presence_of :name, :email

  def to_s
    name
  end
end
