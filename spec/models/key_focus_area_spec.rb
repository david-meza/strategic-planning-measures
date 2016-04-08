require 'rails_helper'

describe KeyFocusArea do
  
  let(:user) { create(:user) }
  let(:kfa)  { build(:key_focus_area) }


  it "is valid with default attributes" do
    expect(kfa).to be_valid
  end

  it "saves with default attributes" do
    expect{ kfa.save! }.to_not raise_error
  end

  it "responds to the author association" do
    expect(kfa).to respond_to(:author)
  end

end