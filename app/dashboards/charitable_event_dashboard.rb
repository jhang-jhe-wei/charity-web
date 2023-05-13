# frozen_string_literal: true

require 'administrate/base_dashboard'

class CharitableEventDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    bonus: Field::String,
    ended_at: Field::DateTime,
    event_type: Field::String,
    extra_infos: Field::Text,
    favorites: Field::HasMany,
    img_url: Field::Url,
    link: Field::Url,
    location: Field::String,
    name: Field::String,
    organizer: Field::String,
    registration_deadline: Field::Date,
    remark: Field::String,
    source_type: Field::String,
    started_at: Field::DateTime,
    favorite_users: Field::HasMany,
    working_type: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    id
    name
    location
    started_at
    ended_at
    registration_deadline
    bonus
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    name
    bonus
    started_at
    ended_at
    registration_deadline
    event_type
    location
    organizer
    remark
    source_type
    favorite_users
    working_type
    created_at
    updated_at
    link
    img_url
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    name
    bonus
    started_at
    ended_at
    registration_deadline
    event_type
    location
    organizer
    remark
    source_type
    favorite_users
    working_type
    created_at
    updated_at
    link
    img_url
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how charitable events are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(charitable_event)
    charitable_event.name
  end
end
