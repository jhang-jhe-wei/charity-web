# frozen_string_literal: true

class CharitableEventsController < ApplicationController
  def index
    @charitable_events = CharitableEvent.all
    apply_filters(params[:query])
    @charitable_events = @charitable_events.page(params[:page].to_i)
    @query = params[:query]
  end

  def search
    @cities = CharitableEvent.pluck(:city).compact.uniq
  end

  private

  def apply_filters(query_params)
    query = Rack::Utils.parse_query(query_params)

    filter_by_city(query['city']) if query['city'].present? && query['city'] != '全國'
    filter_by_started_at(query['started_at']) if query['started_at'].present?
    filter_by_ended_at(query['ended_at']) if query['ended_at'].present?
  end

  def filter_by_city(city)
    @charitable_events = @charitable_events.where(city:)
  end

  def filter_by_started_at(started_at)
    @charitable_events = @charitable_events.where('started_at >= ?', started_at)
  end

  def filter_by_ended_at(ended_at)
    @charitable_events = @charitable_events.where('ended_at >= ?', ended_at)
  end
end
