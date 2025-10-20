#!/bin/bash

# Run tests for vim-hyperstyle Lua implementation
# Supports both Plenary.nvim (full test suite) and basic tests

echo "Running vim-hyperstyle Lua tests..."

# Function to run basic tests
run_basic_tests() {
    echo "Running basic functionality tests..."
    nvim --headless -l test.lua
    return $?
}

# Function to run full Plenary test suite
run_plenary_tests() {
    echo "Running full test suite with Plenary..."
    
    # Try different Plenary commands for compatibility
    if nvim --headless -c "lua require('plenary.test_harness').test_directory('tests')" -c "quit" 2>/dev/null; then
        return $?
    elif nvim --headless -c "PlenaryBustedDirectory tests/" -c "qa!" 2>/dev/null; then
        return $?
    else
        echo "Could not run Plenary tests. Falling back to basic tests."
        return 1
    fi
}

# Check if we have a specific test type requested
case "${1:-auto}" in
    "basic")
        run_basic_tests
        exit $?
        ;;
    "plenary")
        # Check if plenary is available
        if ! nvim --headless -c "lua require('plenary')" -c "quit" 2>/dev/null; then
            echo "Error: plenary.nvim is required for full test suite."
            echo "Install it with your plugin manager or run: $0 basic"
            exit 1
        fi
        run_plenary_tests
        exit $?
        ;;
    "auto"|*)
        echo "Auto-detecting test framework..."
        
        # Try Plenary first if available
        if nvim --headless -c "lua require('plenary')" -c "quit" 2>/dev/null; then
            echo "Found Plenary.nvim, running full test suite..."
            if run_plenary_tests; then
                echo "✅ Plenary tests completed"
                exit 0
            else
                echo "⚠️ Plenary tests had issues, running basic tests..."
                run_basic_tests
                exit $?
            fi
        else
            echo "Plenary.nvim not found, running basic tests..."
            run_basic_tests
            exit $?
        fi
        ;;
esac