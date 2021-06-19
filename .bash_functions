#!/bin/bash

function git() {
  if [ "$1" = "root" ]; then
    local root="$(command git rev-parse --show-toplevel 2> /dev/null || pwd)"

    if [ "$#" -eq 1 ]; then
      echo "$root"
    elif [ "$2" = "cd" ]; then
        command cd $root
    else
      shift
      (cd "$root" && eval "$@")
    fi
  elif [ "$1" = "prune" ]; then
    command git fetch --prune
    command git fetch upstream --prune
  elif [ "$1" = "tree" ]; then
    command git log --graph
  elif [ "$1" = "branch" ] && [ "$#" -eq 1 ]; then
    command git branch -a
  else
    command git "$@"
  fi
}

function cd() {
  builtin cd "$@" && ls -A --color=auto
}

function man() {
  LESS_TERMCAP_md=$'\e[01;31m' \
  LESS_TERMCAP_me=$'\e[0m' \
  LESS_TERMCAP_se=$'\e[0m' \
  LESS_TERMCAP_so=$'\e[01;44;33m' \
  LESS_TERMCAP_ue=$'\e[0m' \
  LESS_TERMCAP_us=$'\e[01;32m' \
  command man "$@"
}

function __docker_default_args(){
  # Default args
  local args="--interactive"
  local args+=" --tty"
  local args+=" --rm"
  local args+=" --user $(id --user):$(id --group)"
  local args+=" --volume $PWD:/usr/src/app"
  local args+=" --volume $HOME/.deno:/deno-dir"
  local args+=" --workdir /usr/src/app"
  # Generate random port to use https://en.wikipedia.org/wiki/Ephemeral_port#range
  # 65535-49152=16383 (max range)
  local port=$((49152 + $RANDOM % 16383))
  local args+=" --env PORT=$port"
  local args+=" --network host"
  # Check if .env file exits
  local file=".env"
  if [ -f $file ]; then
    local args+=" --env-file $file"
  fi
  echo "$args"
}

function deno() {
  local version="alpine"
  # Check for flag version
  if [ "$1" = "--docker" ]; then
    shift
    local version="$1"
    shift
  fi
  local args=$(__docker_default_args)

  docker run \
    $args \
    denoland/deno:$version \
    deno "$@"
}

function node() {
  local version="current-alpine"
  # Check for flag version
  if [ "$1" = "--docker" ]; then
    shift
    local version="$1"
    shift
  fi
  local args=$(__docker_default_args)

  docker run \
    $args \
    node:$version \
    node "$@"
}

function npm() {
  if [ "$2" = "-g" ] || [ "$2" = "--global" ]; then
    command npm "$@"
  else
    local version="current-alpine"
    # Check for flag version
    if [ "$1" = "--docker" ]; then
      shift
      local version="$1"
      shift
    fi
    local args=$(__docker_default_args)

    docker run \
      $args \
      node:$version \
      npm "$@"
  fi
}

function yarn() {
  if [ "$1" = "global" ]; then
    command yarn "$@"
  else
    local version="current-alpine"
    # Check for flag version
    if [ "$1" = "--docker" ]; then
      shift
      local version="$1"
      shift
    fi
    local args=$(__docker_default_args)

    docker run \
      $args \
      node:$version \
      yarn "$@"
  fi
}

function docker-compose() {
  if [ "$1" = "up" ]; then
    shift
    command docker-compose up --remove-orphans --build "$@"
  else
    command docker-compose "$@"
  fi
}
