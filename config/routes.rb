# frozen_string_literal: true

Rails.application.routes.draw do
  scope '/sesame/api' do
    get 'tickets', to: 'tickets#index'
    get 'trips', to: 'trips#index'
  end
end
