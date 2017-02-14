class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :create, :read, :update, :destroy, to: :crud
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
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities

    user ||= User.new # guest user (not logged in)
    if user.superadmin_role?
      can :manage, :all
      can :access, :rails_admin       # only allow admin users to access Rails Admin
      can :dashboard                  # allow access to dashboard

    #Supervisor
    elsif user.supervisor_role?
      #can do something, for example -> can :manage, User
    #User
    elsif user.user_role?
        can :manage, :all
      can :access, :rails_admin       # only allow admin users to access Rails Admin
      can :dashboard  
      #add new contact
      can :create, Contact

      #News
      can :read, News

      #Products
      can :read, Product

      #Cart, LineItems
      can :manage, [Cart, LineItem]
      cannot :read, [Cart, LineItem]

      #Orders
      can :create, Order

      #Users
      can :crud, User

      can :crud, Review

     

    #Guest user (not logged in)
    else
      can :create, User
      can :read, [News, Product]
      can [:manage], [Cart, LineItem]
      cannot :read, [Cart, LineItem]
      can :create, Order
      cannot :create, Review
    end 
  end
end
