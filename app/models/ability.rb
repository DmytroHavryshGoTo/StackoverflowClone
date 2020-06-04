# frozen_string_literal: true

class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user

    if user
      user.admin? ? admin_ability : user_ability
    else
      guest_ability
    end
  end

  def guest_ability
    can :read, :all
  end

  def user_ability
    guest_ability
    can :create, [Question, Answer, Attachment]
    can :update, [Question, Answer], user: user
    can :destroy, [Question, Answer], user: user
    can :mark_best, Answer do |answer|
      user == answer.question.user
    end

    can [:destroy, :update], Attachment do |attch|
      user == attch.attachable.user 
    end
  end

  def admin_ability
    can :manage, :all
  end
end
