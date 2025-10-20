# Migration to Lua-based vim-hyperstyle

This document outlines the migration from Python to native Lua implementation of vim-hyperstyle.

## What Changed

### Core Implementation
- **Python dependencies removed**: No longer requires Python support in Vim/Neovim
- **Native Lua implementation**: All expansion logic now runs in Neovim's embedded Lua
- **Improved performance**: Direct Lua execution without Python bridge overhead
- **Better integration**: Uses Neovim's native Lua APIs

### File Structure
```
lua/hyperstyle/
├── init.lua          # Main expansion logic (was hyperstyle.py)
├── definitions.lua   # CSS property definitions (was definitions.py) 
└── indexer.lua       # Property indexing system (was indexer.py)

autoload/hyperstyle_lua.vim  # Lua bridge functions
plugin/hyperstyle_lua.vim    # Plugin entry point (Lua version)
tests/                       # Plenary.nvim test suite
├── hyperstyle_spec.lua
└── integration_spec.lua
run_tests.sh                # Test runner script
```

### Requirements
- **Old**: Vim 8.0+ or Neovim 0.2+ with Python 2/3 support
- **New**: Neovim 0.5+ (for Lua support)

### Testing Framework
- **Old**: Vader.vim test framework
- **New**: Plenary.nvim test framework (more popular for Neovim Lua plugins)

## Migration Steps

### For Users
1. **Update Requirements**: Ensure you have Neovim 0.5+
2. **Remove Python**: No need to install Python or configure Python paths
3. **Plugin Loading**: The plugin will automatically detect and use the Lua implementation
4. **Configuration**: All existing configuration options remain the same

### For Developers
1. **Test Suite**: Run tests with `./run_tests.sh` (requires plenary.nvim)
2. **Development**: All logic is now in `lua/hyperstyle/` directory
3. **Debugging**: Use Neovim's `:lua` command for debugging

## Compatibility

### What Remains the Same
- All keyboard shortcuts and mappings
- All expansion patterns and rules
- All configuration options (`g:hyperstyle_use_colon`, etc.)
- Support for CSS, SCSS, Less, Sass, and Stylus
- Auto-pairs plugin compatibility

### Improvements
- **Faster startup**: No Python initialization overhead
- **Better error handling**: Native Lua error reporting
- **Future-proof**: Uses modern Neovim APIs
- **Easier maintenance**: Pure Lua codebase

## Testing the Migration

### Running Tests
```bash
# Install plenary.nvim first (with your plugin manager)
# Then run:
./run_tests.sh
```

### Manual Testing
1. Open a CSS file in Neovim
2. Try basic expansions:
   - `dib` → `display: inline-block`
   - `m10` → `margin: 10px`
   - `brad4` → `border-radius: 4px`

### Comparing Functionality
The Lua implementation maintains 100% functional compatibility with the Python version. All test cases from the original Vader tests have been ported to Plenary tests.

## Rollback Plan

If you encounter issues, you can temporarily use the original Python implementation by:
1. Using the old plugin files (`plugin/hyperstyle.vim`, `autoload/hyperstyle.vim`)
2. Ensuring Python support is available
3. The old files remain in the repository for compatibility

## Future Development

With the Lua migration complete:
- Easier contribution process (no Python knowledge required)
- Better integration with Neovim ecosystem
- Potential for additional Neovim-specific features
- Faster iteration and debugging cycles

## Support

If you encounter any issues with the Lua implementation:
1. Check that you have Neovim 0.5+
2. Verify plenary.nvim is installed for running tests
3. Compare behavior with the original Python implementation
4. Report issues with detailed reproduction steps