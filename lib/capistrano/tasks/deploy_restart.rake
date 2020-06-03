# namespace :deploy do
#   desc "Restart Unicorn"
#   task :restart do
#     on roles(:app) do
#       execute "sudo /home/ubuntu/stackoverblow/current/config/unicorn_init.sh restart"
#       # ^^^ Depending on your environment settings you may find using
#       # "restart" as an argument to unicorn_init.sh doesn't reload your app's
#       # code. If that's the case, try using "upgrade" instead of "restart".
#     end
#   end
# end
# after "deploy:finishing", "deploy:restart"