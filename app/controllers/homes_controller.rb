# frozen_string_literal: true

class HomesController < ApplicationController
  def recommend
    @current_page = params[:page] || 1
    @charitable_events = CharitableEvent.all.page(@current_page)
  end

  def my_favorite; end

  def fan_page; end

  def volunteer_journey; end
end
