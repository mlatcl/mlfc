#!/bin/bash

# Get all test names
test_names=$(grep -E "^@test" test/install.bats | cut -d'"' -f2)

# Function to clean up any lingering processes
cleanup() {
    echo "Cleaning up..."
    pkill -f bats-core || true
    exit 1
}

# Set up trap for cleanup
trap cleanup SIGINT SIGTERM

# Run each test individually
for test in $test_names; do
    echo "=== Running test: $test ==="
    
    # Run the test with a timeout and capture output
    output=$(timeout 5 bats --tap --filter "$test" test/install.bats 2>&1)
    status=$?
    
    # Print the output
    echo "$output"
    
    # Check if the test timed out
    if [ $status -eq 124 ]; then
        echo "Test timed out after 5 seconds"
        cleanup
    fi
    
    # Check if the test failed
    if [ $status -ne 0 ]; then
        echo "Test failed with status $status"
        cleanup
    fi
    
    echo "=== Test completed successfully ==="
    echo
    
    # Add a small delay between tests
    sleep 0.5
done

echo "All tests completed successfully" 