require 'rails_helper'

describe Membership do

  let(:membership){FactoryGirl.create(:membership)}



  it "assigned user can be found via membership" do
      membership.save
      expect(Membership.membership_exists?(membership.user.id,membership.group.id)).to be(true)
  end

  it "unassigned user can't be found via membership" do
    membership.save
    expect(Membership.membership_exists?(-5,-3)).to be(false)
  end

  it "Membership can be find with group and user_id" do
    membership.save
    m = Membership.find_mem(membership.user.id, membership.group.id)
    expect(m.id).to eq(membership.id)
  end

  it "Membership.find returns null for search with bad ids" do
    membership.save
    m = Membership.find_mem(-6, -2)
    expect(m).to eq(nil)
  end




end