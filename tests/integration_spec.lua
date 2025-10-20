-- Integration tests for vim-hyperstyle mimicking original Vader tests
local hyperstyle = require('hyperstyle')

describe('hyperstyle integration tests', function()
  -- These tests mirror the original Vader test cases
  describe('property expansion tests', function()
    it('expands properties on colon', function()
      -- Original test: "di" + ":" -> "display:"
      assert.equals('display:', hyperstyle.expand_property('di', true))
    end)

    it('expands margin shorthand', function()
      -- Original test: "m" + ":" -> "margin:"
      assert.equals('margin:', hyperstyle.expand_property('m', true))
    end)

    it('expands padding shorthand', function()
      -- Original test: "pad" + ":" -> "padding:"
      assert.equals('padding:', hyperstyle.expand_property('pad', true))
    end)
  end)

  describe('statement expansion tests', function()
    it('expands value keywords', function()
      -- Original test: "margin: a" + ";" -> "margin: auto;"
      assert.equals('margin: auto', hyperstyle.expand_statement('margin: a', true))
    end)

    it('formats property values with proper spacing', function()
      -- Original test: "margin:auto" + ";" -> "margin: auto;"
      assert.equals('margin: auto', hyperstyle.expand_statement('margin:auto', true))
    end)

    it('expands full statements', function()
      -- Original test: "dib" + ";" -> "display: inline-block;"
      assert.equals('display: inline-block', hyperstyle.expand_statement('dib', true))
    end)

    it('expands numeric values with default units', function()
      -- Original test: "brad4" + ";" -> "border-radius: 4px;"
      assert.equals('border-radius: 4px', hyperstyle.expand_statement('brad4', true))
    end)
  end)

  describe('advanced expansion tests', function()
    it('handles negative values', function()
      assert.equals('margin: -15px', hyperstyle.expand_statement('m-15', true))
    end)

    it('handles float values', function()
      assert.equals('opacity: 0.5', hyperstyle.expand_statement('opacity: 0.5', true))
    end)

    it('expands flex shorthand', function()
      assert.equals('flex: 1 auto', hyperstyle.expand_statement('fle1auto', true))
    end)

    it('handles multiple value properties', function()
      assert.equals('margin: 10px 20px', hyperstyle.expand_statement('margin: 10 20', true))
    end)
  end)

  describe('stylus/sass support', function()
    it('works without colons', function()
      assert.equals('display inline-block', hyperstyle.expand_statement('dib', false))
      assert.equals('margin 0 auto', hyperstyle.expand_statement('m0a', false))
    end)

    it('expands properties without colons', function()
      assert.equals('margin', hyperstyle.expand_property('m', false))
      assert.equals('display', hyperstyle.expand_property('di', false))
    end)
  end)

  describe('edge cases', function()
    it('preserves zero values', function()
      assert.equals('margin: 0', hyperstyle.expand_statement('margin: 0', true))
      assert.equals('padding: 0', hyperstyle.expand_statement('padding: 0', true))
    end)

    it('handles unitless properties', function()
      assert.equals('z-index: 10', hyperstyle.expand_statement('z-index: 10', true))
      assert.equals('line-height: 1.5', hyperstyle.expand_statement('line-height: 1.5', true))
    end)

    it('expands background shorthand', function()
      assert.equals('background:', hyperstyle.expand_property('bg', true))
      assert.equals('background-image:', hyperstyle.expand_property('bgimage', true))
    end)
  end)
end)