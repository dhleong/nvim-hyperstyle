# Testing vim-hyperstyle Lua Implementation

## Quick Start
```bash
# Run all available tests (auto-detects framework)
./run_tests.sh

# Run just basic functionality tests (no dependencies)
./run_tests.sh basic

# Run full Plenary test suite (requires plenary.nvim)
./run_tests.sh plenary
```

## Test Frameworks

### Basic Tests (`./run_tests.sh basic`)
- **Requirements**: Just Neovim 0.5+
- **Coverage**: Core functionality verification
- **Speed**: Very fast
- **Usage**: Ideal for quick checks and CI

```bash
./run_tests.sh basic
```

**Example Output:**
```
=== vim-hyperstyle Lua Basic Tests ===
✅ Module loaded successfully
✅ Simple statement expansion
✅ Statement with units
✅ Zero values
✅ Auto values
✅ Property expansion
✅ Property without colon
=== Results ===
Passed: 6
Failed: 0
Total:  6
```

### Plenary Tests (`./run_tests.sh plenary`)
- **Requirements**: Neovim 0.5+ + plenary.nvim
- **Coverage**: Comprehensive test suite
- **Speed**: Slower but thorough
- **Usage**: Development and detailed testing

**Install plenary.nvim:**
```vim
" vim-plug
Plug 'nvim-lua/plenary.nvim'

" packer.nvim
use 'nvim-lua/plenary.nvim'

" lazy.nvim
{ 'nvim-lua/plenary.nvim' }
```

### Auto-Detection (`./run_tests.sh`)
The default mode automatically:
1. Checks if plenary.nvim is available
2. Runs full test suite if available
3. Falls back to basic tests if not

## Current Test Status

### ✅ Working (Basic Tests)
- Module loading and initialization
- Core statement expansions (`dib` → `display: inline-block`)
- Numeric values with units (`brad4` → `border-radius: 4px`)
- Zero values (`m0` → `margin: 0`)
- Auto values (`m0a` → `margin: 0 auto`)
- Property expansion (`display` → `display:`)
- Stylus/Sass mode (no colons)

### ⚠️ Known Issues (Plenary Tests)
- **Fuzzy matching priority**: Single letters (`m`, `di`) match wrong properties
- **Multi-value properties**: `margin: 10 20` doesn't add units to both values
- **Complex patterns**: Some advanced shortcuts not working (`fle1auto`)

## Manual Testing
```bash
# Test core functionality
nvim --headless -c "lua local h = require('hyperstyle')"
nvim --headless -c "lua print(h.expand_statement('dib', true))"  # → display: inline-block
nvim --headless -c "lua print(h.expand_property('pad', true))"   # → padding:
```

## Test Files Structure
```
tests/
├── hyperstyle_spec.lua     # Unit tests for core functions
└── integration_spec.lua    # Integration tests mimicking Vader tests

test.lua                    # Simple test runner (no dependencies)
run_tests.sh               # Main test runner script
```

## Development Workflow

1. **Quick check**: `./run_tests.sh basic` 
2. **Full validation**: `./run_tests.sh plenary`
3. **Manual testing**: Try actual CSS expansions in Neovim
4. **CI/Automation**: Use basic tests for fast feedback

## Debugging Failed Tests

### View detailed test output:
```bash
./run_tests.sh plenary 2>&1 | grep -A 5 "Fail"
```

### Test specific functionality:
```bash
nvim --headless -c "lua local h = require('hyperstyle'); print('Test:', h.expand_statement('YOUR_TEST', true))" -c quit
```

### Compare with original behavior:
Enable both Python and Lua versions and compare outputs.