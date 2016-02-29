# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


KeyFocusArea.destroy_all
Objective.destroy_all
PerformanceMeasure.destroy_all
MeasureReport.destroy_all
User.destroy_all


def generate_key_focus_areas
  KeyFocusArea.create(name: "Economic Development and Innovation", goal: "Maintain and grow a diverse economy through partnerships and innovation to support large and small businesses and entrepreneurs, while providing employment opportunities for all citizens.")
  KeyFocusArea.create(name: "Art and Cultural Resources", goal: "Embrace Raleigh’s diverse offerings of arts and cultural resources as iconic celebrations of our community that provide entertainment, community and economic benefit.")
  KeyFocusArea.create(name: "Growth and Natural Resources", goal: "Encourage a diverse, vibrant built environment that preserves and protects the community’s natural resources while encouraging sustainable growth that complements existing development.")
  KeyFocusArea.create(name: "Organizational Excellence", goal: "Foster a transparent, nimble organization of employees challenged to provide high quality, responsive and innovative services efficiently and effectively.")
  KeyFocusArea.create(name: "Safe, Vibrant and Healthy Community", goal: "Promote a clean, engaged community environment where people feel safe and enjoy access to community amenities that support a high quality of life.")
  KeyFocusArea.create(name: "Transportation and Transit", goal: "Develop an equitable, citywide transportation network for pedestrians, cyclists, automobiles and transit that is linked to regional municipalities, rail and air hubs.")
end

generate_key_focus_areas