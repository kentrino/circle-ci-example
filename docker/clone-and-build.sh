#!/bin/bash

set -ex

repo=kentrino/circle-ci-example.git
remote_head=`git ls-remote git@github.com:$repo | grep HEAD | awk '{print $1}'`

cache_dir=~/cache
local_repo_dir=$cache_dir/fluentd

if [ -e $local_repo_dir ]; then
  cd $local_repo_dir
  local_head=`git log -n 1 | grep 'commit ' | awk '{print $2}'`
else
  local_head="not-exist"
fi

if [ ! -e $cache_dir ]; then
  mkdir $cache_dir
fi

if [ $remote_head != $local_head -o ! -e $cache_dir/fluentd.tar ]; then
  if [ -d $local_repo_dir ]; then
    cd $local_repo_dir
    git pull --rebase
  else
    git clone git@github.com:$repo $local_repo_dir
  fi
  docker build -t fluentd $local_repo_dir/docker
  docker save fluentd > $cache_dir/fluentd.tar
else
  docker load < $cache_dir/fluentd.tar
fi
