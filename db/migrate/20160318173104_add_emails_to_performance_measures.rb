class AddEmailsToPerformanceMeasures < ActiveRecord::Migration
  def change
    add_column :performance_measures, :data_contact_person_email, :string
    add_column :performance_measures, :person_reporting_data_to_bms_email, :string
  end
end
