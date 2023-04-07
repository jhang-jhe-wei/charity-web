# frozen_string_literal: true

class NotifiesController < ApplicationController
  def index
    @auth_link = LineNotify.get_auth_link(current_user.line_id)
  end

  def tutorial; end
end
