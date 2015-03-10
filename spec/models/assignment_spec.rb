require 'rails_helper'

describe Assignment do
  it "no assigments in db before creating some." do
    expect(Assignment.all.count).to eq(0)
  end
end
