require 'spec_helper'

describe Users do
  # unit_test 1: test for adding correctly
  before { @user = Users.new(name: "WhatTheFuck", password: "123") }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:password) }
  it { should respond_to(:count) }

  it { should be_valid }

  
  # unit_test 2: test for name presence
  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end


  # unit_test 3: test for name length
  describe "when name is too long" do
    before do
      @user.name = 'f'*129 
    end
    it { should_not be_valid }
  end

  describe "when password is too long" do
    before do 
      @user.name = "WhatTheFuck"
      @user.password = 'f' * 129
    end
    it { should_not be_valid }
  end

  describe "when password is empty" do
    before do 
      @user.name = "WhatTheFuck"
      @user.password = " "
    end
    it { should be_valid }
  end
  
  # unit_test 4: uniqueness test
  describe "when name is already taken" do
    before do
      @user.name = "WhatTheFuck"
      duplicate_user = @user.dup
      duplicate_user.save
    end
    it { should_not be_valid }
  end

  # unit_test 5: uniqueness for various up_lower cases
  describe "when name is already taken with difference case" do
    before do
      dup_user_up = @user.dup
      dup_user_up.name = dup_user_up.name.upcase
      dup_user_up.save
    end
    it { should_not be_valid }
  end


end



