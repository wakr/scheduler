require 'rails_helper'

describe Group do
  it " does not exists in db before creating one." do
    expect(Group.count).to eq(0)
  end

  it " does not accept group without name or too long name." do
    Group.create name:"   "
    Group.create name:"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaddddddddddddddddddddd"

    expect(Group.count).to eq(0)
  end

  describe " has created groups and " do

    before :each do
      @group = FactoryGirl.create(:group)
    end

    it " allows destroy group." do
      expect{
        Group.first.destroy
      }.to change{Group.count}.from(1).to(0)
    end

    it " allows user to join " do
      u = FactoryGirl.create :user
      expect{
        Group.first.members << u
      }.to change{Membership.count}.from(0).to(1)
    end

    it "when destroying Group also memberships are destroyed" do
      u = FactoryGirl.create :user
      g = Group.first
      g.members << u
      expect{
          g.destroy
      }.to change {Membership.count}.from(1).to(0)
    end

  end

end
