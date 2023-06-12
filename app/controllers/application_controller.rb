# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Rails.application.routes.url_helpers
  before_action :line_messaging_login

  def line_messaging_login
    user = User.from_kamigo(params)
    sign_in user if user.present?
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) ||
      if resource.is_a?(User) && resource.admin?
        admin_root_path
      else
        super
      end
  end
end
