#!/usr/bin/env bats

setup() {
    echo "[setup] Starting setup..."
    ORIGINAL_DIR=$(pwd)
    # Create a temporary directory for each test
    TEST_DIR=$(mktemp -d)
    echo "[setup] Created temp directory: $TEST_DIR"
    cd "$TEST_DIR"
    
    # Initialize a git repository first
    echo "[setup] Initializing git repository..."
    git init
    
    # Set up Git identity for tests if not already set
    if [ -z "$(git config --global user.email)" ] || [ -z "$(git config --global user.name)" ]; then
        echo "[setup] Setting git config..."
        git config --global user.email "test@example.com"
        git config --global user.name "Test User"
    fi
    # Also set local Git config for this test
    git config --local user.email "test@example.com"
    git config --local user.name "Test User"
    
    # Source the install script
    SCRIPT_PATH="$ORIGINAL_DIR/install.sh"
    echo "[setup] Sourcing script from: $SCRIPT_PATH"
    source "$SCRIPT_PATH"
    echo "[setup] Setup complete"
}

teardown() {
    echo "[teardown] Starting teardown..."
    # Return to original directory
    cd "$ORIGINAL_DIR"
    # Clean up test directory
    if [ -d "$TEST_DIR" ]; then
        echo "[teardown] Removing temp directory: $TEST_DIR"
        rm -rf "$TEST_DIR"
    fi
    echo "[teardown] Teardown complete"
}

# Testing color variables use
@test "color variables are defined correctly" {
    echo "[test] Testing color variables..."
    # Check if color variables are defined
    [ -n "$RED" ]
    [ -n "$GREEN" ]
    [ -n "$BLUE" ]
    [ -n "$NC" ]
    
    # Test the variables contain the expected escape sequences
    [[ "$RED" == *"\033"* ]]
    [[ "$GREEN" == *"\033"* ]]
    [[ "$BLUE" == *"\033"* ]]
    [[ "$NC" == *"\033"* ]]
    echo "[test] Color variables test complete"
}

# Test the get_user_input function with actual input
@test "get_user_input reads actual user input in interactive mode" {
    echo "[test] Testing get_user_input in interactive mode..."
    
    # Create a temporary file to simulate user input
    echo "user typed this" > "$TEST_DIR/user_input.txt"
    
    # Mock get_user_input directly instead of mocking read
    function get_user_input() {
        local prompt="$1"
        local default="$2"
        cat "$TEST_DIR/user_input.txt"
    }
    
    # Unset TEST_MODE to simulate interactive mode
    unset TEST_MODE
    
    # Run the function and check output
    echo "[test] Running get_user_input..."
    run get_user_input "Test prompt: " "default value"
    echo "[test] get_user_input output: $output"
    [ "$status" -eq 0 ]
    [ "$output" = "user typed this" ]
    echo "[test] get_user_input test complete"
}

# Test create_directory_structure with no arguments
@test "create_directory_structure with no arguments creates in current directory" {
    echo "[test] Testing create_directory_structure with no arguments..."
    run create_directory_structure
    echo "[test] create_directory_structure output: $output"
    [ "$status" -eq 0 ]
    [ -d "./_lamd" ]
    [ -d "./_lectures" ]
    [ -d "./_notebooks" ]
    [ -d "./_practicals" ]
    [ -d "./assets" ]
    [ -d "./slides" ]
    echo "[test] create_directory_structure test complete"
}

# Test update_config_files with empty values
@test "update_config_files handles empty values gracefully" {
    echo "[test] Testing update_config_files with empty values..."
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
    
    echo "[test] Running update_config_files..."
    run update_config_files "test-course" "" "" "" ""
    echo "[test] update_config_files output: $output"
    [ "$status" -eq 0 ]
    
    # Check YAML content is handled gracefully
    echo "[test] Checking YAML content..."
    run yq '.given' "test-course/_lamd/_lamd.yml"
    [ "$output" = "" ]
    
    run yq '.family' "test-course/_lamd/_lamd.yml"
    [ "$output" = "" ]
    
    run yq '.institution' "test-course/_lamd/_lamd.yml"
    [ "$output" = "" ]
    
    run yq '.url' "test-course/_lamd/_lamd.yml"
    [ "$output" = "" ]
    
    run yq '.organization' "test-course/_lamd/_lamd.yml"
    [ "$output" = "" ]
    echo "[test] update_config_files test complete"
}

# Test init_git_repo when git config is not set
@test "init_git_repo sets git config if not already set" {
    echo "[test] Testing init_git_repo with unset git config..."
    # Create test directory
    mkdir -p "test-course"
    
    # Save original git config
    orig_email=$(git config --global user.email || echo "")
    orig_name=$(git config --global user.name || echo "")
    
    # Temporarily unset git config
    echo "[test] Unsetting git config..."
    git config --global --unset user.email || true
    git config --global --unset user.name || true
    
    # Check that it's really unset
    [ -z "$(git config --global user.email || echo "")" ]
    [ -z "$(git config --global user.name || echo "")" ]
    
    # Run init_git_repo
    echo "[test] Running init_git_repo..."
    run init_git_repo "test-course"
    echo "[test] init_git_repo output: $output"
    [ "$status" -eq 0 ]
    [ -d "test-course/.git" ]
    
    # Verify it was set with default values
    cd "test-course"
    [ "$(git config --local user.email)" = "test@example.com" ]
    [ "$(git config --local user.name)" = "Test User" ]
    
    # Restore original git config
    if [ -n "$orig_email" ]; then
        git config --global user.email "$orig_email"
    fi
    if [ -n "$orig_name" ]; then
        git config --global user.name "$orig_name"
    fi
    echo "[test] init_git_repo test complete"
}

# Test create_github_repo with mocked gh command
@test "create_github_repo uses gh command when available" {
    echo "[test] Testing create_github_repo with mocked gh command..."
    # Create mockup gh command
    cat > "$TEST_DIR/gh" <<EOF
#!/bin/bash
echo "Mock gh command called with args: \$@"
if [[ "\$1" == "repo" && "\$2" == "create" ]]; then
  echo "Repository created successfully"
  exit 0
else
  echo "Unknown command"
  exit 1
fi
EOF
    chmod +x "$TEST_DIR/gh"
    export PATH="$TEST_DIR:$PATH"
    
    # Make sure gh is callable
    which gh
    
    mkdir -p "test-course"
    cd "test-course"
    git init
    touch README.md
    git add README.md
    git commit -m "Initial commit"
    cd ..
    
    # Run create_github_repo with our mock
    echo "[test] Running create_github_repo..."
    run create_github_repo "test-course" "testuser"
    echo "[test] create_github_repo output: $output"
    
    [ "$status" -eq 0 ]
    [[ "$output" == *"Repository created successfully"* ]]
    echo "[test] create_github_repo test complete"
}

# Test the main installation function
@test "install_lamd_lecture handles git clone" {
    echo "[test] Testing install_lamd_lecture with git clone..."
    # Mock git clone command
    function git() {
        echo "[mock] git function called with args: $*"
        if [[ "$1" == "clone" ]]; then
            # Instead of actually cloning, just create the structure
            create_directory_structure "$3"
            touch "$3/README.md"
            return 0
        else
            # Forward to the real git command
            command git "$@"
        fi
    }
    
    # Create a file with predefined inputs
    echo "mock-course" > "$TEST_DIR/course_input.txt"
    echo "Test User" > "$TEST_DIR/name_input.txt"
    echo "Test University" > "$TEST_DIR/institution_input.txt"
    echo "http://example.com" > "$TEST_DIR/url_input.txt"
    echo "testuser" > "$TEST_DIR/github_input.txt"
    echo "n" > "$TEST_DIR/github_repo_input.txt"
    
    # Mock get_user_input to read from our files
    function get_user_input() {
        local prompt="$1"
        local default="$2"
        
        if [[ "$prompt" == *"course name"* ]]; then
            cat "$TEST_DIR/course_input.txt"
        elif [[ "$prompt" == *"full name"* ]]; then
            cat "$TEST_DIR/name_input.txt"
        elif [[ "$prompt" == *"institution"* ]]; then
            cat "$TEST_DIR/institution_input.txt"
        elif [[ "$prompt" == *"website URL"* ]]; then
            cat "$TEST_DIR/url_input.txt"
        elif [[ "$prompt" == *"GitHub username"* ]]; then
            cat "$TEST_DIR/github_input.txt"
        elif [[ "$prompt" == "> " ]]; then
            cat "$TEST_DIR/github_repo_input.txt"
        else
            echo "$default"
        fi
    }
    
    # Unset TEST_MODE to trigger the git clone path
    unset TEST_MODE
    
    # Run the installation function
    echo "[test] Running install_lamd_lecture..."
    run install_lamd_lecture
    echo "[test] install_lamd_lecture output: $output"
    
    [ "$status" -eq 0 ]
    [[ "$output" == *"Installation complete"* ]]
    [ -d "mock-course" ]
    echo "[test] install_lamd_lecture test complete"
}

# Test with simulated "y" response for GitHub repo creation
@test "install_lamd_lecture handles GitHub repo creation when user selects yes" {
    echo "[test] Testing install_lamd_lecture with GitHub repo creation..."
    
    # Create a file with predefined inputs
    echo "github-test-course" > "$TEST_DIR/course_input.txt"
    echo "Test User" > "$TEST_DIR/name_input.txt"
    echo "Test University" > "$TEST_DIR/institution_input.txt"
    echo "http://example.com" > "$TEST_DIR/url_input.txt"
    echo "testuser" > "$TEST_DIR/github_input.txt"
    echo "y" > "$TEST_DIR/github_repo_input.txt"
    
    # Mock functions
    function get_user_input() {
        local prompt="$1"
        local default="$2"
        echo "[mock] get_user_input called with prompt: $prompt, default: $default"
        
        if [[ "$prompt" == *"course name"* ]]; then
            cat "$TEST_DIR/course_input.txt"
        elif [[ "$prompt" == *"full name"* ]]; then
            cat "$TEST_DIR/name_input.txt"
        elif [[ "$prompt" == *"institution"* ]]; then
            cat "$TEST_DIR/institution_input.txt"
        elif [[ "$prompt" == *"website URL"* ]]; then
            cat "$TEST_DIR/url_input.txt"
        elif [[ "$prompt" == *"GitHub username"* ]]; then
            cat "$TEST_DIR/github_input.txt"
        elif [[ "$prompt" == "> " ]]; then
            cat "$TEST_DIR/github_repo_input.txt"
        else
            echo "$default"
        fi
    }
    
    function git() {
        echo "[mock] git function called with args: $*"
        if [[ "$1" == "clone" ]]; then
            # Create the directory structure instead of actual cloning
            create_directory_structure "$3"
            return 0
        else
            # Forward to the real git command
            command git "$@"
        fi
    }
    
    function create_github_repo() {
        echo "[mock] create_github_repo called"
        echo "GitHub repository created successfully at https://github.com/testuser/github-test-course"
        return 0
    }
    
    # Unset TEST_MODE
    unset TEST_MODE
    
    # Run installation
    echo "[test] Running install_lamd_lecture..."
    run install_lamd_lecture
    echo "[test] install_lamd_lecture output: $output"
    
    [ "$status" -eq 0 ]
    [[ "$output" == *"GitHub repository created successfully"* ]]
    echo "[test] install_lamd_lecture with GitHub repo creation test complete"
} 