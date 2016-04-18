KeyFocusArea.destroy_all
Objective.destroy_all
PerformanceMeasure.destroy_all
MeasureReport.destroy_all
User.destroy_all


MULTIPLIER = 25


def generate_key_focus_areas
  KeyFocusArea.create(name: "Economic Development and Innovation", goal: "Maintain and grow a diverse economy through partnerships and innovation to support large and small businesses and entrepreneurs, while providing employment opportunities for all citizens.", created_by_user_id: User.admins.sample.id)
  KeyFocusArea.create(name: "Art and Cultural Resources", goal: "Embrace Raleigh’s diverse offerings of arts and cultural resources as iconic celebrations of our community that provide entertainment, community and economic benefit.", created_by_user_id: User.admins.sample.id)
  KeyFocusArea.create(name: "Growth and Natural Resources", goal: "Encourage a diverse, vibrant built environment that preserves and protects the community’s natural resources while encouraging sustainable growth that complements existing development.", created_by_user_id: User.admins.sample.id)
  KeyFocusArea.create(name: "Organizational Excellence", goal: "Foster a transparent, nimble organization of employees challenged to provide high quality, responsive and innovative services efficiently and effectively.", created_by_user_id: User.admins.sample.id)
  KeyFocusArea.create(name: "Safe, Vibrant and Healthy Community", goal: "Promote a clean, engaged community environment where people feel safe and enjoy access to community amenities that support a high quality of life.", created_by_user_id: User.admins.sample.id)
  KeyFocusArea.create(name: "Transportation and Transit", goal: "Develop an equitable, citywide transportation network for pedestrians, cyclists, automobiles and transit that is linked to regional municipalities, rail and air hubs.", created_by_user_id: User.admins.sample.id)
end

def generate_objective
  obj = Objective.new
  obj.key_focus_area_id = KeyFocusArea.ids.sample
  loop do
    obj.name = "Objective #{(rand * MULTIPLIER + 1).to_i}"
    break unless Objective.find_by(name: obj.name, key_focus_area_id: obj.key_focus_area_id) # Generate objectives until we find a unique one on a KFA scope
  end
  obj.description = Faker::Lorem.sentence
  obj.created_by_user_id = User.admins.sample.id
  obj.save!
end

def generate_performance_measure
  measure = PerformanceMeasure.new
  measure.measurable_type = ["Objective", "KeyFocusArea"].sample
  measure.measurable_id = measure.measurable_type.constantize.ids.sample
  measure.description = Faker::Lorem.sentence
  measure.unit_of_measure = Faker::Lorem.word
  measure.created_by_user_id = User.admins.sample.id
  measure.save!
end

def generate_measure_report
  report = MeasureReport.new
  report.performance_measure_id = PerformanceMeasure.ids.sample
  # 13-24 months ago
  report.date_start = (rand * 12 + 13).to_i.months.ago.to_date
  # 1-12 months ago
  report.date_end = (rand * 12 + 1).to_i.months.ago.to_date
  report.performance = ((rand * 20).to_i * 5).to_s + " percent " + ["increase", "decrease"].sample
  report.status = "All good! Thumbs up :)"
  report.created_by_user_id = User.ids.sample
  report.save!
end

def generate_user
  user = User.new
  loop do
    user.email = Faker::Internet.user_name(nil, %w(.)) + "@raleighnc.gov"
    break unless User.find_by_email(user.email) # Generate emails until we find a unique one
  end
  pw = Faker::Internet.password
  user.password = pw
  user.password_confirmation = pw
  user.confirmed_at = Time.now
  user.save!
end


admin = User.create(email: "david.meza@raleighnc.gov", password: "devpassword", password_confirmation: "devpassword", admin: true, confirmed_at: Time.now)

# only run 1 time...
generate_key_focus_areas

MULTIPLIER.times do
  generate_user
end

MULTIPLIER.times do
  generate_objective
end

(MULTIPLIER * 3).times do
  generate_performance_measure
end

(MULTIPLIER * 4).times do
  generate_measure_report
end