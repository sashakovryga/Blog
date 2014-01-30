class UserController < Devise
	def user_params
      params.require(:user).permit(:user_name, :role_ids, :block)
  end
   before_save :setup_role, :setup_block

  def role?(role)
      return !!self.roles.find_by_name(role.to_s.camelize)
  end

  # Default role is "Registered"
  def setup_role 
    if self.role_ids.empty?     
      self.role_ids = [2] 
    end
  end

  def setup_block
    if self.block.empty?     
      self.block = false 
    end
  end
end