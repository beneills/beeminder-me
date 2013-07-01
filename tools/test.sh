#!/bin/sh

# check we're in the root directory first
ls _posts > /dev/null && ((sleep 2; chromium-browser "http://localhost:4000") \
    & jekyll serve --watch) \
    || echo "Error: not in root directory!"

