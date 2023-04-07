# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :line_messaging_login

  def line_messaging_login
    user = User.from_kamigo(params)
    sign_in user if user.present?
  end
end
