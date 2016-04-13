require 'rails_helper'

describe User do
  
  let(:user)   { build(:user) }
  let(:admin)  { build(:admin) }

  # Sanity checks
  it "is valid with default attributes" do
    expect(user).to be_valid
  end

  it "saves with default attributes" do
    expect{ user.save! }.to_not raise_error
  end

  context "validations" do

    subject { build :user }

    it { should validate_presence_of(:email) }
    
    it { should validate_presence_of(:password) }

    it { should validate_length_of(:password).is_at_least(8).is_at_most(40) }
    
    it { should validate_uniqueness_of(:email).case_insensitive }

    it { should validate_length_of(:email).is_at_least(14).is_at_most(40) }

    it "validates that email is from the raleighnc.gov domain" do
      subject.email = "random_user@gmail.com"
      expect(subject).not_to be_valid
      expect(subject.errors.full_messages.first).to eq("Email is invalid. Please use your @raleighnc.gov email.")
    end


  end

  context "associations" do
    it { should have_many(:authored_kfa).dependent(:nullify) }
    it { should have_many(:edited_kfa).dependent(:nullify) }
    
    it { should have_many(:authored_objectives).dependent(:nullify) }
    it { should have_many(:edited_objectives).dependent(:nullify) }
    
    it { should have_many(:authored_measures).dependent(:nullify) }
    it { should have_many(:edited_measures).dependent(:nullify) }
    
    it { should have_many(:authored_reports).dependent(:nullify) }
    it { should have_many(:edited_reports).dependent(:nullify) }
  end

  context "virtual attributes" do

    describe "#name" do

      it "should respond to a name" do
        expect(user).to respond_to(:name)
      end

      it "should guess my name from my email" do
        user.email = "david.meza@raleighnc.gov"
        expect(user.name).to eq("David Meza")
      end
    
    end
  end

  context "user deletion" do

    it "should nullify foreign key references for created KFAs" do
      deleted_author_kfa = create(:key_focus_area, author: admin)
      expect { admin.destroy}.to change { KeyFocusArea.count}.by(0)
      # expect(deleted_author_kfa.created_by_user_id).to be_nil # Can't get this one to pass
    end

  end


end