# frozen_string_literal: true

Rails.application.routes.draw do
  root 'homes#recommend'
  get '即時推薦', to: 'homes#recommend'
  get '我的最愛', to: 'homes#my_favorite'
  get '社群連結', to: 'homes#fan_page'
end
