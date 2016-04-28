require 'rails_helper'

describe MeasureReport do
  
  let(:report)     { build(:report) }
  let(:user)       { create(:user) }
  let(:admin)      { create(:admin) }

  # Sanity checks
  it "is valid with default attributes" do
    expect(report).to be_valid
  end

  it "saves with default attributes" do
    expect{ report.save! }.to_not raise_error
  end

  context "validations" do

    subject { build :report }

    it { should validate_presence_of(:date_start) }
    it { should validate_presence_of(:date_end) }
    
    # it { should validate_presence_of(:status) }
    
    it { should validate_presence_of(:performance_measure_id) }

    it { should accept_nested_attributes_for(:performance_factor_entries).allow_destroy(true) }

  end

  context "associations" do
    it { should belong_to :performance_measure }
    
    it { should have_many(:performance_factor_entries).dependent(:destroy) }
    it { should have_many(:performance_factors).through(:performance_factor_entries) }
    it { should have_many(:form_factors).through(:performance_measure).source(:performance_factors) }

    it { should belong_to :author }

    it { should belong_to :last_editor }

  end

  context "user permissions" do

    it "should allow all users to create a new report" do
      expect{ create(:report, author: admin) }.not_to raise_error
      expect{ create(:report, author: user) }.not_to raise_error
    end

    it "shouldn't allow a random user to update another user's report" do
      report.save
      expect{ report.update!(status: "Done!", last_editor: user) }.to raise_error(ActiveRecord::RecordInvalid)
    end

  end

  context "edge cases" do

    it "should not be deleted if author is deleted" do
      deleted_author_report = create(:report, author: user)
      user.destroy
      expect(MeasureReport.where(id: deleted_author_report.id)).to exist
    end

  end


  context "class methods" do
    describe "filter_query" do
      it "should return all records if not query was specified" do
        create_list(:report, 5)
        expect(MeasureReport.filter_query({})).to match_array(MeasureReport.all)
        expect(MeasureReport.filter_query({some_empty_param: ""})).to match_array(MeasureReport.all)
      end
      
      it "should filter by the specified query" do
        list = create_list(:report, 5)
        sample_report = list.first
        expect(MeasureReport.filter_query({"measure_reports.id": sample_report.id.to_s})).to match_array([sample_report])
      end
    end
  end


end