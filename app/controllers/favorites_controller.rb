class FavoritesController < ApplicationController
  before_action :set_event

  def index
    @events = current_user.charitable_events
  end

  def add
    current_user.charitable_events << @event
    @events = current_user.charitable_events
    render :index
  end

  def delete
    current_user.charitable_events.delete(@event)
    @events = current_user.charitable_events
    render :index
  end

  private

  def set_event
    @event = CharitableEvent.find_by(name: params[:event_name])
  end
end
