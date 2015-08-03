class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, :all
      cannot :create, [Quote, QuoteItem, QuoteCompany, QuoteUser]
      cannot :upload_offer, Quote
    end

    if user.company?
      can [:read, :upload_offer], Quote do |quote|
        quote.quote_companies.by_company(user.userable_id).present?
      end
      can [:read, :update], Company, id: user.userable_id
      can :manage, [Product, Location], company_id: user.userable_id
      can :read, User, userable_id: user.userable_id
      can :update, User, id: user.id
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
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
