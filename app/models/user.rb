class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
        # attr_accessible :user_name
  has_and_belongs_to_many :roles
   before_save :setup_role
   has_many :chapers
attr_accessible :email, :password, :password_confirmation, :user_name
  def role?(role)
      return !!self.roles.find_by_name(role.to_s)
  end

  # Default role is "users"
  def setup_role 
    if self.role_ids.empty?     
      self.role_ids = [2] 
    end
  end


end
