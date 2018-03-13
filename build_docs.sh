#!/bin/bash

# Docs by jazzy
# https://github.com/realm/jazzy
# ------------------------------

jazzy \
  --module 'VolumeBar' \
  --source-directory 'VolumeBar' \
  --readme './README.md' \
  --author 'Sachin Patel' \
  --author_url 'https://gizmosachin.com' \
  --github_url 'https://github.com/gizmosachin/VolumeBar' \
  --root-url 'https://gizmosachin.github.io/VolumeBar/docs' \
  --xcodebuild-arguments -scheme,VolumeBar \
  --copyright '© 2018 [Sachin Patel](http://gizmosachin.com).' \

# Open docs in browser
open ./docs/index.html