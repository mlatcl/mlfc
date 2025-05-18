#!/usr/bin/env bash

# Load the install script
load() {
    local name="$1"
    local filename
    filename="${BATS_TEST_DIRNAME}/../install.sh"
    source "$filename"
}

# Export functions for testing
export -f get_user_input
export -f create_directory_structure
export -f update_config_files
export -f init_git_repo
export -f create_github_repo
export -f install_lamd_lecture 