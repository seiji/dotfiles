COMPONENTS = %w(emacs tmux zsh git)
home = ENV['HOME'] 

task :default => [:install]

desc "install"
task :install do
  COMPONENTS.each do |c|
    `stow -S -t #{home} -v #{c}`
  end
end

desc "uninstall"
task :uninstall do
  COMPONENTS.each do |c|
    `stow -D -t #{home} -v #{c}`
  end
end
