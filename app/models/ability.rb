class Ability
  include CanCan::Ability

  def initialize(user)
      
   user ||= User.new # guest user (not logged in)   
   if user.role? :superadmin
     can :manage, :all
     can :index, User
   end
   if user.role? :admin
     can :manage, :all 
     #cannot [:destroy, :edit, :update], User #do everything except delete users or change their permissions if you are using superadmin or tiered admins.  end
     #if user.role? :creator
      #can [:create, :destroy, :show], :all
     #cannot [:index, :destroy, :show, :edit, :update], User
     #can [:show, :edit, :update], User do |current_user|
       #user.id == current_user.id #User can only edit the current user.
     #end
    #end
   elsif user.role? :user
     can :read, :all
     cannot :index, User
     can [:show, :edit, :update], User do |current_user|
       user.id == current_user.id #User can only edit the current user.
     end
   else 
     can :read, :all
     cannot :index, User
   end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
