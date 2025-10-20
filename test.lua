-- Alternative test runner for vim-hyperstyle
-- Run with: nvim --headless -l test.lua

-- Add current directory to Lua path
package.path = './lua/?.lua;./lua/?/init.lua;' .. package.path

-- Simple test function
local function run_basic_tests()
    print("=== vim-hyperstyle Lua Basic Tests ===")
    print("")
    
    -- Load the module
    local ok, hyperstyle = pcall(require, 'hyperstyle')
    if not ok then
        print("❌ FAILED: Could not load hyperstyle module")
        print("Error: " .. tostring(hyperstyle))
        return false
    end
    print("✅ Module loaded successfully")
    
    -- Test cases
    local tests = {
        -- Statement expansion tests
        {
            name = "Simple statement expansion",
            func = "expand_statement",
            input = {"dib", true},
            expected = "display: inline-block"
        },
        {
            name = "Statement with units",
            func = "expand_statement", 
            input = {"brad4", true},
            expected = "border-radius: 4px"
        },
        {
            name = "Zero values",
            func = "expand_statement",
            input = {"m0", true}, 
            expected = "margin: 0"
        },
        {
            name = "Auto values", 
            func = "expand_statement",
            input = {"m0a", true},
            expected = "margin: 0 auto"
        },
        -- Property expansion tests
        {
            name = "Property expansion",
            func = "expand_property",
            input = {"display", true},
            expected = "display:"
        },
        {
            name = "Property without colon",
            func = "expand_property", 
            input = {"display", false},
            expected = "display"
        }
    }
    
    local passed = 0
    local failed = 0
    
    for _, test in ipairs(tests) do
        local result = hyperstyle[test.func](unpack(test.input))
        if result == test.expected then
            print("✅ " .. test.name)
            passed = passed + 1
        else
            print("❌ " .. test.name)
            print("   Expected: '" .. test.expected .. "'")
            print("   Got:      '" .. result .. "'")
            failed = failed + 1
        end
    end
    
    print("")
    print("=== Results ===")
    print("Passed: " .. passed)
    print("Failed: " .. failed)
    print("Total:  " .. (passed + failed))
    
    return failed == 0
end

-- Run tests and exit with appropriate code
local success = run_basic_tests()
if success then
    vim.cmd("quitall")
else
    vim.cmd("cquit")  -- Exit with error code
end