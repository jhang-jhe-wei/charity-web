# frozen_string_literal: true

class FavoritesController < ApplicationController
  before_action :set_event

  def index
    @events = current_user.charitable_events
  end

  def add
    current_user.favorites.create!(charitable_event: @event)
    @events = current_user.charitable_events
    render :index
  rescue ActiveRecord::RecordInvalid => e
    render json: { type: 'text', text: e.message }
  end

  def delete
    current_user.charitable_events.delete(@event)
    @events = current_user.charitable_events
    render :index
  end

  private

  def set_event
    @event = CharitableEvent.find(params[:event_id])
  end
end
