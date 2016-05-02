require 'rails_helper'

describe PerformanceFactorEntry do
  
  let(:entry)   { build(:factor_entry) }

  # Sanity checks
  it "is valid with default attributes" do
    expect(entry).to be_valid
  end

  it "saves with default attributes" do
    expect{ entry.save! }.to_not raise_error
  end

  context "validations" do

    it { should validate_presence_of(:data) }
    
    it { should validate_presence_of(:performance_factor_id) }

  end

  context "associations" do
    it { should belong_to(:performance_factor) }
    
    it { should belong_to(:measure_report) }
  end

end