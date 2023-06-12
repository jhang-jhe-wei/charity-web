# frozen_string_literal: true

class CharitableEventsController < ApplicationController
  def index
    @cities = CharitableEvent.pluck(:city).compact.uniq
    @charitable_events = CharitableEvent.all
    apply_filters(query)
  end

  def search
    @cities = CharitableEvent.pluck(:city).compact.uniq
  end

  private

  def query
    @query ||= begin
      query_params = Rack::Utils.parse_query(params[:query] || '')
      {
        city: params[:city] || query_params['city'],
        started_at: params[:started_at] || query_params['started_at'],
        ended_at: params[:ended_at] || query_params['ended_at'],
        page: params[:page] || query_params['page'],
        name: params[:name]
      }
    end
  end

  def apply_filters(query)
    filter_by_name(query[:name]) if query[:name].present?
    filter_by_city(query[:city]) if query[:city].present? && query[:city] != '全國'
    filter_by_started_at(query[:started_at]) if query[:started_at].present?
    filter_by_ended_at(query[:ended_at]) if query[:ended_at].present?
    filter_by_page(query[:page])
  end

  def filter_by_name(name)
    @charitable_events = @charitable_events.where('name LIKE ?', "%#{name}%")
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

  def filter_by_page(page)
    @charitable_events = @charitable_events.page(page)
  end
end
