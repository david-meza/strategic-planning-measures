class User < ActiveRecord::Base
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # ----------------------- Associations --------------------

  has_many  :authored_kfa, 
            foreign_key: :created_by_user_id, 
            class_name: "KeyFocusArea",
            dependent: :nullify
  has_many  :edited_kfa, 
            foreign_key: :last_updated_by_user_id, 
            class_name: "KeyFocusArea",
            dependent: :nullify
  
  has_many  :authored_objectives, 
            foreign_key: :created_by_user_id, 
            class_name: "Objective",
            dependent: :nullify
  has_many  :edited_objectives, 
            foreign_key: :last_updated_by_user_id, 
            class_name: "Objective",
            dependent: :nullify
  
  has_many  :authored_measures, 
            foreign_key: :created_by_user_id, 
            class_name: "PerformanceMeasure",
            dependent: :nullify
  has_many  :edited_measures, 
            foreign_key: :last_updated_by_user_id, 
            class_name: "PerformanceMeasure",
            dependent: :nullify
  
  has_many  :authored_reports, 
            foreign_key: :created_by_user_id, 
            class_name: "MeasureReport",
            dependent: :nullify
  has_many  :edited_reports, 
            foreign_key: :last_updated_by_user_id, 
            class_name: "MeasureReport",
            dependent: :nullify


  # ----------------------- Validations --------------------

  validates :email,
            :format => { with: /\A([\w\.%\+\-]+)@raleighnc\.gov\z/i, message: "is invalid. Please use your @raleighnc.gov email." },
            length: { in: 14..40 },
            presence: true,
            uniqueness: true

  validates :password,
            :length => { :in => 8..40 },
            allow_nil: true

  # ----------------------- Methods --------------------

  def name
    self.email.sub(/@.+\z/i, "").gsub(/\W/i, " ").titleize
  end

  def self.admins
    where(admin: true)
  end

end
