lock '3.5'

# Change these

set :repo_url,        'git@github.com:farid-92/student-crm.git'
set :application,     'student-crm'

set :deploy_to, 'home/altyn/student-srm'


set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}





namespace :deploy do

  # namespace :db do
  #
  #   desc "Load the database schema if needed"
  #   task load: [:set_rails_env] do
  #     on primary :db do
  #       if not test(%Q[[ -e "#{shared_path.join(".schema_loaded")}" ]])
  #         within release_path do
  #           with rails_env: fetch(:rails_env) do
  #             execute :rake, "db:schema:load"
  #             execute :touch, shared_path.join(".schema_loaded")
  #           end
  #         end
  #       end
  #     end
  #   end
  # end
  #
  # before "deploy:migrate", "deploy:db:load"

  desc 'Runs rake db:seed for SeedMigrations data'
  task :seed => [:set_rails_env] do
    on primary fetch(:migration_role) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "db:seed"
        end
      end
    end
  end

  after 'deploy:migrate', 'deploy:seed'

  after :restart, :clear_cache do

    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end

# ps aux | grep puma    # Get puma pid
# kill -s SIGUSR2 pid   # Restart puma
# kill -s SIGTERM pid   # Stop puma