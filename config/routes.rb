Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'sms#index'

  post '/inbound/sms/', to: 'sms#inbound'
  post '/outbound/sms/', to: 'sms#outbound'

  get '*path' => 'sms#http_not_allowed'
end
