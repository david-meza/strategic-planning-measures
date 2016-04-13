require 'rails_helper'

describe PerformanceMeasure do
  
  let(:measure)     { build(:measure) }
  let(:m_no_obj)    { build(:measure_no_objective) }
  let(:user)        { create(:user) }
  let(:admin)       { create(:admin) }

  # Sanity checks
  it "is valid with default attributes" do
    expect(measure).to be_valid
  end

  it "saves with default attributes" do
    expect{ measure.save! }.to_not raise_error
  end

  context "validations" do

    subject { build :measure }

    it { should validate_presence_of(:description) }
    
    it { should validate_presence_of(:unit_of_measure) }
    
    it { should validate_presence_of(:measurable_id) }
    it { should validate_presence_of(:measurable_type) }
    
    it { should accept_nested_attributes_for(:performance_factors).allow_destroy(true) }

  end

  context "associations" do
    it { should belong_to :measurable }
    it { should belong_to :key_focus_area }
    it { should belong_to :objective }
    
    it { should have_many(:measure_reports).dependent(:destroy) }
    it { should have_many(:performance_factors).dependent(:destroy) }

    it { should belong_to :author }

    it { should belong_to :last_editor }

  end

  context "user permissions" do

    it "shouldn't allow non-admins to create/update a new measure" do
      expect{ create(:measure, author: user) }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "shouldn't raise an error when admins do the same" do
      expect{ create(:measure, author: admin) }.not_to raise_error
    end

  end

  context "edge cases" do

    it "should not be deleted if author is deleted" do
      deleted_author_measure = create(:measure, author: admin)
      admin.destroy
      expect(PerformanceMeasure.where(id: deleted_author_measure.id)).to exist
    end

  end

  context "virtual attributes" do
    describe "#kfa_name" do
      it "should give us the name of the key focus area if the measurable is an objective" do
        expect(measure.kfa_name).to eq(measure.measurable.key_focus_area.name)
      end

      it "should give us the name of the key focus area if the measurable is a key focus area" do
        expect(m_no_obj.kfa_name).to eq(m_no_obj.measurable.name)
      end
    end

    describe "#parents" do
      it "should always return an array with two objects" do
        expect(measure.parents.length).to eq(2)
      end

      specify "first parent should be a Key Focus Area" do
        expect(measure.parents.first).to be_an_instance_of(KeyFocusArea)
      end
      
      specify "second parent should be an Objective" do
        expect(measure.parents.second).to be_an_instance_of(Objective)
      end

      specify "if immediate parent is a KFA, objective should be a non-persisted record with name N/A" do
        objective = m_no_obj.parents.second
        expect(objective.name).to eq("N/A")
        expect(objective.new_record?).to be true
      end

    end
  end

  context "class methods" do
    describe "filter_results" do
      it "should return the measures where the data contact is the current user" do
        my_measure = create(:measure, data_contact_person_email: user.email)
        create_list(:measure, 5) # Create some other data so we can make sure our method is filtering properly
        search = PerformanceMeasure.filter_results({filter_data_contact: true}, user)
        expect(search.length).to eq(1)
        expect(search).to match_array([my_measure])
      end

      it "should return all the measures if a query parameter wasn't passed" do
        create_list(:measure, 5) # Create some measures so we know it's not just matching two empty arrays
        expect(PerformanceMeasure.filter_results({}, user)).to match_array(PerformanceMeasure.all)
      end
    end
  end


end