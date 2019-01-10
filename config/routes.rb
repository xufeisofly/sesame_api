# frozen_string_literal: true

Rails.application.routes.draw do
  scope '/sesame_api' do
    get 'tickets', to: 'tickets#index'
  end
end
