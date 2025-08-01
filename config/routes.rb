# frozen_string_literal: true

Rails.application.routes.draw do
  root 'gratifications#new'
  resources :gratifications, only: %i[new create]
end
