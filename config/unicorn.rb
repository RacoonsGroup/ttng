rails_root = '.'
pid_file   = "#{rails_root}/tmp/pids/unicorn.pid"
socket_file= '/tmp/project.sock'
log_file   = "#{rails_root}/log/unicorn.log"
err_log    = "#{rails_root}/log/unicorn_error.log"

timeout 300
worker_processes 2
listen socket_file, backlog: 1024
pid pid_file
stderr_path err_log
stdout_path log_file

preload_app true