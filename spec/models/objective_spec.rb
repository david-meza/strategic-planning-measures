require 'rails_helper'

describe Objective do
  
  let(:objective)   { build(:objective) }
  let(:user)        { create(:user) }
  let(:admin)       { create(:admin) }

  # Sanity checks
  it "is valid with default attributes" do
    expect(objective).to be_valid
  end

  it "saves with default attributes" do
    expect{ objective.save! }.to_not raise_error
  end

  context "validations" do

    subject { build :objective }

    it { should validate_presence_of(:name) }
    
    it { should validate_presence_of(:description) }
    
    it { should validate_presence_of(:key_focus_area_id) }
    
    it do 
      should validate_uniqueness_of(:name).
      scoped_to(:key_focus_area_id).
      with_message("duplicate objective in this Key Focus Area").
      case_insensitive
    end

  end

  context "associations" do
    it { should belong_to :key_focus_area }
    
    it { should have_many(:measures).dependent(:destroy) }

    it { should belong_to :author }

    it { should belong_to :last_editor }

  end

  context "user permissions" do

    it "shouldn't allow non-admins to create/update a new objective" do
      expect{ create(:objective, author: user) }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "shouldn't raise an error when admins do the same" do
      expect{ create(:objective, author: admin) }.not_to raise_error
    end

  end

  context "edge cases" do

    it "should not be deleted if author is deleted" do
      deleted_author_objective = create(:objective, author: admin)
      admin.destroy
      expect(Objective.where(id: deleted_author_objective.id)).to exist
    end

  end


end