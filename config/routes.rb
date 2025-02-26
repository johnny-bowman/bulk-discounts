Rails.application.routes.draw do
  root "welcome#index"

  get "/merchants/:id/dashboard", to: "merchants#show"

  get "/items/:id/edit", to: "items#edit"
  patch "/items/:id", to: "items#update"
  get "/items/:id", to: "items#show"

  resources :merchants, only: [:show, :edit] do
    resources :items, only: [:index, :new, :create, :update, :show]
    resources :invoices, only: [:index, :show]
    resources :invoice_items, only: [:update]
  end

  get "/admin", to: "admin/dashboard#index"
  get "/admin/merchants", to: "admin/merchants#index"
  get "/admin/invoices", to: "admin/invoices#index"
  get "/admin/merchants/new", to: "admin/merchants#new"
  get "/admin/invoices/:id", to:"admin/invoices#show"
  get "/admin/merchants/:id", to:"admin/merchants#show"
  patch "/admin/merchants/:id", to: "admin/merchants#update"
  get "/admin/merchants/:id/edit", to: "admin/merchants#edit"
  post "/admin/merchants/create", to: "admin/merchants#create"

  get "/merchants/:id/bulk_discounts", to: "bulk_discounts#index"
  get "/merchants/:id/bulk_discounts/new", to: "bulk_discounts#new"
  get "/bulk_discounts/:id", to: "bulk_discounts#show"
  post "/merchants/:id/bulk_discounts", to: "bulk_discounts#create"
  delete "/merchants/:id/bulk_discounts/:id", to: "bulk_discounts#delete"
  get "/bulk_discounts/:id/edit", to: "bulk_discounts#edit"
  patch "/bulk_discounts/:id", to: "bulk_discounts#update"
end
