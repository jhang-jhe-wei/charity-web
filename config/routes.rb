# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'homes#recommend'
  get '即時推薦', to: 'homes#recommend'
  get '即時推薦/:page', to: 'homes#recommend'
  get '我的最愛', to: 'homes#my_favorite'
  get '社群連結', to: 'homes#fan_page'
  get '訂閱通知', to: 'notifies#index'
  get '志工歷程', to: 'homes#volunteer_journey'
  get '訂閱通知/:notify_type', to: 'subscriptions#subscribe'
  get '取消通知/:notify_type', to: 'subscriptions#revoke'
  get 'notify操作說明', to: 'notifies#tutorial'
  get 'notifies/callback', to: 'notifies#callback'
end
