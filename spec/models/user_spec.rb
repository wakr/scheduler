require 'rails_helper'

describe User do

  it "when no users created, database is empty." do
    expect(User.all.count).to eq(0)
  end

  it "does not allow to create user without a name" do
    expect(User.create(birthdate: Date.new(1999,9,2))).not_to be_valid
  end

  it "does not allow to create user with a bad password" do
    expect(User.create(name: "Samu",birthdate: Date.new(1999,9,2), password: "abc", password_confirmation: "abc")).not_to be_valid
  end

  it "does not allow to create user with a mismatched password" do
    expect(User.create(name: "Samu",birthdate: Date.new(1999,9,2), password: "abc", password_confirmation: "abs")).not_to be_valid
  end

  describe "created" do
    before :each do
      @user = FactoryGirl.create(:user)
    end

    it "has the name and birthday set correctly" do
      expect(User.first.name).to eq(@user.name)
      expect(User.first.birthdate.year).to eq(@user.birthdate.year)
    end

    it "when saved, count increases" do
      expect(User.all.count).to eq(1)
    end

    it "does not allow duplicate names" do
      user2 = User.create name: "Samu"
      expect(user2).not_to be_valid
    end

    it "when removed, can't be found anymore" do
      @user.destroy
      expect(User.all.count).to eq(0)
    end

    it "to_s method returns name" do
      expect(User.first.to_s).to eq(@user.name)
    end


    describe " logged in and" do

      it "has a secure password hashed" do
        expect(@user.password_digest != @user.password)
      end

    end

  end
    describe " when has more data stored" do

      before :each do
        @user = FactoryGirl.create(:user, :name => "Kaapo")
        @user2 = FactoryGirl.create(:user, :name => "Seppo")
        @user3 = FactoryGirl.create(:user, :name => "Ismo")
        @assignment = FactoryGirl.create(:assignment, :creator_id => @user.id)
        FactoryGirl.create(:user_assignment, :user_id => @user3.id, :assignment_id => @assignment.id)
        @group = FactoryGirl.create(:group, :name => "u_model group")
        FactoryGirl.create(:membership, :user_id => @user.id, :group_id => @group.id)
        FactoryGirl.create(:membership, :user_id => @user2.id, :group_id => @group.id)
        FactoryGirl.create(:membership, :user_id => @user3.id, :group_id => @group.id)
      end

      it " knows own created assignments" do
        fetchedA = @user.get_created_assignments
        expect(fetchedA.count).to eq(1)
      end

      it "can find everybody else expect wanted user" do
        expect(User.all_except(@user).include? @user).to eq(false)
      end

      it "can find everybody who is in the same group but not assigned already to assignment" do

        usrs = User.all_in_same_group_but_not_assigned_to_assignment(@assignment.id, @user)
        u = usrs.first
        expect(u.id).to eq(@user2.id)

      end

    end




end
