#!/usr/bin/env bash

echo "Installing plugins"
cp /var/jenkins_config/plugins.txt /var/jenkins_home
if ! jenkins-plugin-cli -f /var/jenkins_home/plugins.txt; then
  echo "Plugins download failed!"
  exit 0
fi

