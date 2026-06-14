#!/usr/bin/env bash

set -e

cd "$(dirname "$0")"

case "$1" in
  build_generator)
    docker build -f generator/Dockerfile -t generator .
    ;;
  run_generator)
    mkdir -p data
    docker run --rm -v "$(pwd)/data:/data" generator
    ;;
  create_local_data)
    mkdir -p local_data
    python3 generate.py local_data
    ;;
  build_reporter)
    docker build -f reporter/Dockerfile -t reporter .
    ;;
  run_reporter)
    mkdir -p data
    docker run --rm -v "$(pwd)/data:/data" reporter
    if [ -f data/report.html ]; then
      cp data/report.html data/index.html
    fi
    ;;
  structure)
    find . -print | sort
    ;;
  clear_data)
    mkdir -p data
    find data -mindepth 1 -delete
    ;;
  inside_generator)
    docker run --rm -v "$(pwd)/data:/data" generator ls -la /data
    ;;
  inside_reporter)
    docker run --rm -v "$(pwd)/data:/data" reporter ls -la /data
    ;;
  report_server)
    docker rm -f report_server 2>/dev/null || true
    mkdir -p data
    docker run -d --name report_server --rm -p 8080:80 \
      -v "$(pwd)/data:/usr/share/nginx/html:ro" \
      nginx:alpine
    ;;
  *)
    echo "unknown command: $1"
    exit 1
    ;;
esac
