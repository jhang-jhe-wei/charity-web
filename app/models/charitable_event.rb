# frozen_string_literal: true

class CharitableEvent < ApplicationRecord
  store :extra_infos,
        accessors: %i[img_url name organizer location time event_type working_type bonus viewer remark deadline link
                      source_type]
end
