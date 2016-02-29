class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable


  validates :email,
            :format => { :with => /\A([\w\.%\+\-]+)@raleighnc.gov\z/i },
            length: { in: 14..40 },
            presence: true,
            uniqueness: true

  validates :password,
            :length => { :in => 8..40 }
end
