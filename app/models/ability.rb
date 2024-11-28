class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.admin?
      Rails.logger.debug "Admin user detected: #{user.email}"
      can :access, :rails_admin
      can :manage, :all
    else
      Rails.logger.debug "Non-admin user detected: #{user.email}"
      cannot :access, :rails_admin
    end
  end
end
