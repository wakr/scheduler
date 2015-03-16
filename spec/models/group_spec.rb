require 'rails_helper'

describe Group do
  it " does not exists in db before creating one." do
    expect(Group.all.count).to eq(0)
  end

  it " does not accept group without name or too long name." do
    Group.create name:"   "
    Group.create name:"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaddddddddddddddddddddd"

    expect(Group.count).to eq(0)
  end


end
