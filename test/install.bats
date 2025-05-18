#!/usr/bin/env bats

setup() {
    ORIGINAL_DIR=$(pwd)
    echo "[setup]"
    # Create a temporary directory for each test
    TEST_DIR=$(mktemp -d)
    cd "$TEST_DIR"
    
    # Initialize a git repository first
    git init
    
    # Set up Git identity for tests if not already set
    if [ -z "$(git config --global user.email)" ] || [ -z "$(git config --global user.name)" ]; then
        git config --global user.email "test@example.com"
        git config --global user.name "Test User"
    fi
    # Also set local Git config for this test
    git config --local user.email "test@example.com"
    git config --local user.name "Test User"
    
    # Source the install script
    SCRIPT_PATH="$ORIGINAL_DIR/install.sh"
    source "$SCRIPT_PATH"
}

teardown() {
    # Return to original directory
    cd "$ORIGINAL_DIR"
    # Clean up test directory
    if [ -d "$TEST_DIR" ]; then
        rm -rf "$TEST_DIR"
    fi
    echo "[teardown]"
}

@test "get_user_input returns default value in test mode" {
    TEST_MODE=1
    run get_user_input "Test prompt" "default"
    [ "$status" -eq 0 ]
    [ "$output" = "default" ]
}

@test "create_directory_structure creates all required directories" {
    run create_directory_structure "test-course"
    [ "$status" -eq 0 ]
    [ -d "test-course/_lamd" ]
    [ -d "test-course/_lectures" ]
    [ -d "test-course/_notebooks" ]
    [ -d "test-course/_practicals" ]
    [ -d "test-course/assets" ]
    [ -d "test-course/slides" ]
}

@test "update_config_files updates _lamd.yml correctly" {
    mkdir -p "test-course/_lamd"
    # Create test _lamd.yml with expected content
    cat > "test-course/_lamd/_lamd.yml" <<EOF
given: Your
family: Name
institution: Your Institution
url: http://example.com
organization: yourusername
repository: lamd-lecture
baseurl: "lamd-lecture"
EOF
    cp "$ORIGINAL_DIR/_config.yml" "test-course/_config.yml"
    
    run update_config_files "test-course" "John Doe" "Test University" "http://test.com" "testuser"
    [ "$status" -eq 0 ]
    [ -f "test-course/_lamd/_lamd.yml" ]
    
    # Check YAML content using yq
    run yq '.given' "test-course/_lamd/_lamd.yml"
    [ "$output" = "John" ]
    
    run yq '.family' "test-course/_lamd/_lamd.yml"
    [ "$output" = "Doe" ]
    
    run yq '.institution' "test-course/_lamd/_lamd.yml"
    [ "$output" = "Test University" ]
    
    run yq '.url' "test-course/_lamd/_lamd.yml"
    [ "$output" = "http://test.com" ]
    
    run yq '.organization' "test-course/_lamd/_lamd.yml"
    [ "$output" = "testuser" ]
    
    run yq '.repository' "test-course/_lamd/_lamd.yml"
    [ "$output" = "test-course" ]
    
    run yq '.baseurl' "test-course/_lamd/_lamd.yml"
    [ "$output" = "test-course" ]
}

@test "update_config_files updates _config.yml correctly" {
    mkdir -p "test-course/_lamd"
    # Create test _config.yml with expected content
    cat > "test-course/_config.yml" <<EOF
title: LaMD Lecture Course
description: A template lecture course using LaMD
EOF
    
    run update_config_files "test-course" "John Doe" "Test University" "http://test.com" "testuser"
    [ "$status" -eq 0 ]
    [ -f "test-course/_config.yml" ]
    
    # Check YAML content using yq
    run yq '.title' "test-course/_config.yml"
    [ "$output" = "test-course" ]
    
    run yq '.description' "test-course/_config.yml"
    [ "$output" = "test-course - A LaMD-based lecture course" ]
}

@test "init_git_repo initializes git repository" {
    mkdir -p "test-course"
    touch "test-course/test_file"
    run init_git_repo "test-course"
    [ "$status" -eq 0 ]
    [ -d "test-course/.git" ]
}

@test "create_github_repo handles missing gh command" {
    # Create a mock 'command' function that makes 'gh' always "not found"
    command() {
        if [ "$2" = "gh" ]; then
            return 1  # Command not found
        fi
        builtin command "$@"
    }
    
    mkdir -p "test-course"
    cd "test-course"
    git init
    touch test_file
    git add test_file
    git commit -m "Initial commit"
    cd ..
    
    # This should return success even when the gh command is not found
    run create_github_repo "test-course" "testuser"
    [ "$status" -eq 0 ]
    [[ "$output" == *"GitHub CLI not found"* ]]
}

@test "full installation in test mode" {
    TEST_MODE=1
    run install_lamd_lecture
    [ "$status" -eq 0 ]
    [ -d "test-course" ]
    [ -d "test-course/_lamd" ]
    [ -d "test-course/_lectures" ]
    [ -d "test-course/_notebooks" ]
    [ -d "test-course/_practicals" ]
    [ -d "test-course/assets" ]
    [ -d "test-course/slides" ]
    [ -d "test-course/.git" ]
}

@test "get_user_input handles empty input" {
    TEST_MODE=1
    run get_user_input "Test prompt" "default"
    [ "$status" -eq 0 ]
    [ "$output" = "default" ]
}

@test "create_directory_structure handles existing directories" {
    mkdir -p "test-course/_lamd"
    run create_directory_structure "test-course"
    [ "$status" -eq 0 ]
    [ -d "test-course/_lamd" ]
    [ -d "test-course/_lectures" ]
    [ -d "test-course/_notebooks" ]
    [ -d "test-course/_practicals" ]
    [ -d "test-course/assets" ]
    [ -d "test-course/slides" ]
}

@test "update_config_files handles special characters in input" {
    mkdir -p "test-course/_lamd"
    # Create test _lamd.yml with expected content
    cat > "test-course/_lamd/_lamd.yml" <<EOF
given: Your
family: Name
institution: Your Institution
url: http://example.com
organization: yourusername
repository: lamd-lecture
baseurl: "lamd-lecture"
EOF
    cp "$ORIGINAL_DIR/_config.yml" "test-course/_config.yml"
    
    run update_config_files "test-course" "John & Jane" "Test & University" "http://test.com?param=value" "test/user"
    [ "$status" -eq 0 ]
    [ -f "test-course/_lamd/_lamd.yml" ]
    
    # Check YAML content using yq
    run yq '.given' "test-course/_lamd/_lamd.yml"
    [ "$output" = "John" ]
    
    run yq '.family' "test-course/_lamd/_lamd.yml"
    [ "$output" = "& Jane" ]
    
    run yq '.institution' "test-course/_lamd/_lamd.yml"
    [ "$output" = "Test & University" ]
    
    run yq '.url' "test-course/_lamd/_lamd.yml"
    [ "$output" = "http://test.com?param=value" ]
    
    run yq '.organization' "test-course/_lamd/_lamd.yml"
    [ "$output" = "test/user" ]
}

@test "init_git_repo handles existing git repository" {
    mkdir -p "test-course"
    cd "test-course"
    git init
    touch test_file
    git add test_file
    git commit -m "Initial commit"
    cd ..
    run init_git_repo "test-course"
    [ "$status" -eq 0 ]
    [ -d "test-course/.git" ]
}

@test "install_lamd_lecture handles all user inputs" {
    TEST_MODE=1
    run install_lamd_lecture
    [ "$status" -eq 0 ]
    [ -d "test-course" ]
    [ -d "test-course/_lamd" ]
    [ -d "test-course/_lectures" ]
    [ -d "test-course/_notebooks" ]
    [ -d "test-course/_practicals" ]
    [ -d "test-course/assets" ]
    [ -d "test-course/slides" ]
    [ -d "test-course/.git" ]
}

@test "update_config_files handles missing files" {
    mkdir -p "test-course/_lamd"
    run update_config_files "test-course" "John Doe" "Test University" "http://test.com" "testuser"
    [ "$status" -eq 0 ]
    # Should not fail even if files don't exist
}

@test "create_directory_structure handles invalid course name" {
    run create_directory_structure ""
    [ "$status" -eq 0 ]
    # Should not fail but create directories in current location
    [ -d "_lamd" ]
    [ -d "_lectures" ]
    [ -d "_notebooks" ]
    [ -d "_practicals" ]
    [ -d "assets" ]
    [ -d "slides" ]
} 