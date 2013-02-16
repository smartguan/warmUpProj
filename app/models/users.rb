class Users < ActiveRecord::Base
  attr_accessible :count, :name, :password

  before_save { |users| users.name = name.downcase }
  
  validates :name, presence: true, length: { maximum: 128 }, 
                    uniqueness: { case_sensitive: false }
  validates :password, length: { maximum: 128 }
end
