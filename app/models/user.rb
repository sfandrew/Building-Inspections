class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable
  belongs_to :role

  validates_presence_of :name
  before_save :assign_role

  has_many :inspections
  has_many :buildings

  def assign_role
  	self.role = Role.find_by name: "Regular" if self.role.nil?
  end

  def admin?
    self.role.name == "Admin"
  end

  def regular?
    self.role.name == "Regular"
  end
end
