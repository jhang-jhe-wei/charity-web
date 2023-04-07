# frozen_string_literal: true

Rails.application.routes.draw do
  root 'homes#recommend'
  get '即時推薦', to: 'homes#recommend'
end
