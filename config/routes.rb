class SubdomainPresent
  def self.matches?(request)
    request.subdomain.present? && request.subdomain != "www"
  end
end

class SubdomainBlank
  def self.matches?(request)
    request.subdomain.blank? || request.subdomain == 'www'
  end
end


Rails.application.routes.draw do
  resources :home

  constraints(SubdomainBlank) do
    root to: "home#index"
    resources :tenants
  end

  constraints(SubdomainPresent) do
    resources :dashboard
    resources :comments
    resources :tasks
    resources :projects

    # root to: "dashboard#index"
    get "/", to: "dashboard#index"
    # other stuff that you want...
  end


  devise_for :users, controllers: {sessions: "users/sessions"}

  # root to: "home#index"
end
