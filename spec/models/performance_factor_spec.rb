require 'rails_helper'

describe PerformanceFactor do
  
  let(:factor)   { build(:factor) }

  # Sanity checks
  it "is valid with default attributes" do
    expect(factor).to be_valid
  end

  it "saves with default attributes" do
    expect{ factor.save! }.to_not raise_error
  end

  context "validations" do

    it { should validate_presence_of(:label_text) }
    
    it { should validate_presence_of(:field_type) }

    it { should validate_presence_of(:performance_measure_id) }

  end

  context "associations" do
    it { should belong_to(:performance_measure) }
    
    it { should have_many(:performance_factor_entries).dependent(:destroy) }
    
    it { should have_many(:measure_reports).through(:performance_factor_entries) }
  end

end