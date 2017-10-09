from ruby
run apt-get update -y
run apt-get install -y build-essential patch ruby-dev zlib1g-dev liblzma-dev nodejs
run mkdir /myblog
workdir /myblog
add . /myblog
run bundle install
