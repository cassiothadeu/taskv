Rails.application.routes.draw do
  root to: 'login#new'

  get 'tasks', to: 'tasks#index'
  post 'tasks/new', to: 'tasks#create', as: 'new_task'

  patch 'tasks/batch_update', to: 'tasks#batch_update', as: 'update_tasks'

  get 'tasks/:id/edit', to: 'tasks#edit', as: 'edit_task'
  patch 'tasks/:id/edit', to: 'tasks#update'

  get 'tasks/:id/remove', to: 'tasks#remove', as: 'remove_task'
  delete 'tasks/:id/remove', to: 'tasks#destroy'

  get 'login', to: 'login#new'
  post 'login', to: 'login#create'
  delete 'logout', to: 'login#destroy'

  get 'signup', to: 'signup#new'
  post 'signup', to: 'signup#create'
end
