class Point < ActiveRecord::Base
  belongs_to :path

  validates_presence_of :lat, :lng
  validates_format_of :lng, :with => /[-+]?\d+\.\d+/
  validates_format_of :lat, :with => /[-+]?\d+\.\d+/
end
