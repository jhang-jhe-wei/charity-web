# frozen_string_literal: true

class NotifiesController < ApplicationController
  def index
    @auth_link = LineNotify.get_auth_link(current_user.line_id)
  end

  def tutorial; end

  def callback
    code = params[:code]
    current_user = User.find_by(line_id: params[:state])
    token = LineNotify.get_token(code)
    if current_user.line_notify_token
      LineNotify.revoke(current_user.line_notify_token)
    end
    current_user.update(line_notify_token: token)
    LineNotify.send(token, message: '已完成連結')
  end
end
