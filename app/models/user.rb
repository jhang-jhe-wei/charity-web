# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # params[:source_user_id]
  # params[:profile][:displayName]
  def self.from_kamigo(params)
    return unless params[:profile].present? && params[:source_user_id].present?

    line_id = params[:source_user_id]
    name = params.dig(:profile, :displayName)

    user = User.find_or_create_by(line_id:)
    user.update(name:)
    user
  end

  def email_required?
    false
  end

  def password_required?
    false
  end
end
