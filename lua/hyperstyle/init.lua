-- Main hyperstyle expansion functionality
-- Converted from Python hyperstyle.py

local definitions = require('hyperstyle.definitions')
local indexer_mod = require('hyperstyle.indexer')

local M = {}

-- Create and populate the index
local index = indexer_mod.new()
index:index(definitions.definitions)

-- Regular expression patterns (using Lua patterns)
local line_pattern = "^(%s*)(.*)$"
local rule_pattern = "^([%a%-]+):%s*([^%s].*);?$"
local value_pattern = "^([^%.%d%-]*)([%-]?%d*%.?%d+)([xptcmsevrh%%]*)$"
local semicolon_pattern = ";%s*$"
local selectorlike_keywords = {
  "link", "visited", "before", "placeholder", "root", "after", 
  "focus", "hover", "active", "checked", "selected"
}
local ends_in_brace_pattern = ".*{%s*$"

-- Split a line into indent and content
local function split_indent(line)
  local indent, content = string.match(line, line_pattern)
  return indent or "", content or ""
end

-- Split a snippet into property, number and unit
local function split_value(snippet)
  local prop, number, unit = string.match(snippet, value_pattern)
  if prop and number then
    return prop, number, unit or ""
  else
    return nil, nil, nil
  end
end

-- Check if a value looks like a selector
local function is_selectorlike(value)
  if string.match(value, ends_in_brace_pattern) then
    return true
  end
  
  for _, keyword in ipairs(selectorlike_keywords) do
    if string.find(value, keyword) then
      return true
    end
  end
  return false
end

-- Find the closest match to a value given a list of keywords
local function match_keyword(value, keywords)
  if not keywords then return nil end
  
  -- First pass: exact prefix match
  for _, word in ipairs(keywords) do
    if string.sub(word, 1, #value) == value then
      return word
    end
  end
  
  -- Second pass: fuzzy match
  for _, word in ipairs(keywords) do
    if string.find(word, value) then
      return word
    end
  end
  
  return nil
end

-- Expand a single number + unit value
local function unitify(number, unit, default_unit)
  if number == "0" then
    return number
  end

  -- Handle unit shortcuts
  if unit == "p" or unit == "x" then
    unit = "px"
  elseif unit == "m" or unit == "e" then
    unit = "em"
  elseif unit == "" then
    if default_unit == "_" then
      unit = ""
    else
      unit = default_unit or "px"
    end
  end

  return number .. unit
end

-- Expand a value of a given property
local function expand_full_value(val, prop)
  local options = index.full_properties[prop]
  if not options then return nil end

  -- Account for default units
  local default_unit = options.unit
  if default_unit then
    local _, number, unit = split_value(val)
    if number then
      return unitify(number, unit, default_unit)
    end
  end

  -- Account for preset value keywords
  local values = options.values
  if values then
    return match_keyword(val, values)
  end
  
  return nil
end

-- Check if its a simple statement
local function expand_statement_simple(snippet, separator)
  local options = index.statements[snippet]
  if not options then return nil end

  return options.property .. separator .. " " .. options.value
end

-- Expand a statement with both shorthand property and value
local function expand_statement_with_property(snippet, separator)
  local short, value, unit = split_value(snippet)
  if not short or not value then return nil end
  
  local options = index.properties[short]
  if not options then return nil end

  local xvalue = expand_full_value(value .. unit, options.property)
  if xvalue then
    return options.property .. separator .. " " .. xvalue
  end
  
  return nil
end

-- Expand a statement's unit value
local function expand_statement_value(snippet, separator)
  -- Skip non-rules (must match "x: y")
  local prop, value = string.match(snippet, rule_pattern)
  if not prop or not value then return nil end

  -- Skip "complete" rules ("...;")
  if string.match(snippet, semicolon_pattern) then return nil end

  if is_selectorlike(value) then return nil end

  -- Skip imbalanced rules (eg, opening of `scaleX(`)
  local open_count = select(2, string.gsub(value, "%(", ""))
  local close_count = select(2, string.gsub(value, "%)", ""))
  if open_count ~= close_count then return nil end

  local new_value = expand_full_value(value, prop)
  return prop .. separator .. " " .. (new_value or value)
end

-- Main statement expansion function
function M.expand_statement(line, usecolon)
  usecolon = usecolon == nil and true or usecolon
  local indent, snippet = split_indent(line)
  
  local separator = usecolon and ":" or ""

  local result = expand_statement_simple(snippet, separator) or
                 expand_statement_with_property(snippet, separator) or
                 expand_statement_value(snippet, separator)

  if result then
    return indent .. result
  end
  
  return ""
end

-- Property expansion function
function M.expand_property(line, usecolon)
  usecolon = usecolon == nil and true or usecolon
  local indent, snippet = split_indent(line)

  local options = index.properties[snippet]
  if not options then return "" end

  local separator = usecolon and ":" or ""
  return indent .. options.property .. separator
end

-- Export the index for testing/debugging
M.index = index

return M