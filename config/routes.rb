# frozen_string_literal: true

Rails.application.routes.draw do
  get 'tickets', to: 'tickets#index'
end
