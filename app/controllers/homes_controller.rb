# frozen_string_literal: true

class HomesController < ApplicationController
  def recommend
    @charitable_events = CharitableEvent.all.page(params[:page].to_i)
  end

  def fan_page; end

  def volunteer_journey; end
end
