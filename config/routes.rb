# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
    resources :charitable_events
    resources :users

    root to: 'charitable_events#index'
  end
  devise_for :users
  root 'homes#index'
  resources :charitable_events, only: [:index] do
    collection do
      get 'search', to: 'charitable_events#search'
    end
  end
  get '即時推薦(?*query)', to: 'charitable_events#index'

  get '社群連結', to: 'homes#fan_page'
  get '訂閱通知', to: 'notifies#index'
  get '志工歷程', to: 'homes#volunteer_journey'
  get '訂閱通知/:notify_type', to: 'subscriptions#subscribe'
  get '取消通知/:notify_type', to: 'subscriptions#revoke'
  get '我的最愛', to: 'favorites#index', as: :favorites
  get '加入我的最愛/:event_id', to: 'favorites#add'
  get '刪除我的最愛/:event_id', to: 'favorites#delete'
  get 'notify操作說明', to: 'notifies#tutorial'
  get 'notifies/callback', to: 'notifies#callback'
end
