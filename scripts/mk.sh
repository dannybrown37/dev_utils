#!/bin/bash

# Create a new directory and enter it

mk() {
    mkdir -p "$@" && cd "$@"
}
