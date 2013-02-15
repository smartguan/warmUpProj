class Users < ActiveRecord::Base
  attr_accessible :count, :name, :password
end
