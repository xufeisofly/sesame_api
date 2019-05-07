# frozen_string_literal: true

Rails.application.routes.draw do
  scope '/sesame/api' do
    get 'tickets', to: 'tickets#index'
    get 'trips', to: 'trips#index'
    get 'cities', to: 'cities#index'
    post 'add_hot', to: 'cities#add_hot'
    get 'pois', to: 'pois#index'
    get 'position_to_city', to: 'cities#position_to_city'
  end
end
