require 'rails_helper'

describe KeyFocusArea do
  
  let(:user)  { create(:user) }
  let(:admin) { create(:admin) }
  let(:kfa)   { build(:key_focus_area) }

  # Sanity checks
  it "is valid with default attributes" do
    expect(kfa).to be_valid
  end

  it "saves with default attributes" do
    expect{ kfa.save! }.to_not raise_error
  end

  context "validations" do

    subject { build :key_focus_area }

    it { should validate_presence_of(:name) }
    
    it { should validate_presence_of(:goal) }
    
    it do 
      should validate_uniqueness_of(:name).
      with_message("duplicate key focus area with this name").
      case_insensitive
    end

  end

  context "associations" do
    it { should have_many(:objectives).dependent(:destroy) }
    
    it { should have_many(:measures).dependent(:destroy) }

    it { should belong_to :author }

    it { should belong_to :last_editor }

  end

  context "user permissions" do

    it "shouldn't allow non-admins to create/update a new key focus area" do
      expect{ create(:key_focus_area, author: user)}.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "shouldn't raise an error when admins do the same" do
      expect{ create(:key_focus_area, author: admin) }.not_to raise_error
    end

  end

  context "logo / image attachment" do 

    it { should have_attached_file(:logo) }
    
    it { should_not validate_attachment_presence(:logo) }
    
    it { should validate_attachment_content_type(:logo).
          allowing('image/png', 'image/gif').
          rejecting('text/plain', 'text/xml') }
    
    # it { should validate_attachment_size(:logo).less_than(2.megabytes) }

  end

  context "edge cases" do

    it "should not be deleted if author is deleted" do
      deleted_author_kfa = create(:key_focus_area, author: admin)
      admin.destroy
      expect(KeyFocusArea.where(id: deleted_author_kfa.id)).to exist
    end

  end


end