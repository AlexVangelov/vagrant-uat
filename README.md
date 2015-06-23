# vagrant-uat
Vagrant headless parallel UAT (User acceptance testing) with video capture - Template

    vagrant up
    vagrant ssh
    cd /vagrant
    bundle install
    HEADLESS=1 bundle exec parallel_rspec spec
