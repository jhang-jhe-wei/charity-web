class CharitableEventsController < ApplicationController
  def index
    @charitable_events = CharitableEvent.all.page(params[:page].to_i)
  end

  def search; end
end
