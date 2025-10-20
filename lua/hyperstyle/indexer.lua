-- CSS property and statement indexer for hyperstyle
-- Converted from Python indexer.py

local M = {}

-- Indexer class
local Indexer = {}
Indexer.__index = Indexer

function Indexer:new()
  local indexer = {
    properties = {},      -- indexed by shorthand ("bg")
    statements = {},      -- indexed by shorthand ("m0a")
    full_properties = {}, -- indexed by long property name ("margin")
    full_statements = {}, -- indexed by long property name ("margin: auto")
  }
  setmetatable(indexer, Indexer)
  return indexer
end

-- Adds definitions to the index
function Indexer:index(defs)
  self:index_full_props(defs)
  self:index_aliases(defs)
end

function Indexer:index_full_props(defs)
  for _, prop_def in ipairs(defs.properties) do
    local prop, aliases, unit, values = prop_def[1], prop_def[2], prop_def[3], prop_def[4]
    local options = {
      property = prop,
      aliases = {},
      unit = unit,
      values = values
    }
    -- Copy aliases first
    if aliases then
      for _, alias in ipairs(aliases) do
        options.aliases[#options.aliases + 1] = alias
      end
    end
    update_aliases(options)
    self.full_properties[prop] = options
  end

  for _, stmt_def in ipairs(defs.statements) do
    local prop, value, aliases = stmt_def[1], stmt_def[2], stmt_def[3]
    local options = {
      property = prop,
      value = value,
      aliases = {}
    }
    -- Copy aliases
    if aliases then
      for _, alias in ipairs(aliases) do
        options.aliases[#options.aliases + 1] = alias
      end
    end
    local key = options.property .. ": " .. options.value
    self.full_statements[key] = options
  end
end

function Indexer:index_aliases(defs)
  for prop, _ in pairs(self.full_properties) do
    local options = self.full_properties[prop]
    index_item(self.properties, options)
  end

  for key, _ in pairs(self.full_statements) do
    local options = self.full_statements[key]
    index_item(self.statements, options)
  end

  self:remove_tags()
end

-- Workaround to stop tags from being expanded
function Indexer:remove_tags()
  local tags = {'a', 'p', 'br', 'b', 'i', 'li', 'ul', 'div', 'em', 'sup', 'big', 'small', 'sub'}
  for _, tag in ipairs(tags) do
    self.statements[tag] = nil
    self.properties[tag] = nil
  end
end

-- Returns a generator with fuzzy matches for a given string
local function fuzzify(str)
  local matches = {}
  if str and #str > 0 then
    for i = 1, #str do
      table.insert(matches, str:sub(1, i))
    end
  end
  return matches
end

-- Updates options['aliases'] with property defaults
function update_aliases(options)
  local prop = options.property


  -- If the property has dashes, add non-dashed versions
  if string.find(prop, '-') then
    local no_dash = string.gsub(prop, '-', '')
    options.aliases[#options.aliases + 1] = no_dash
  end

  -- Insert the property itself
  options.aliases[#options.aliases + 1] = prop
end

-- Takes aliases and puts them into the properties index
function index_item(properties, options)
  for _, alias in ipairs(options.aliases) do
    local fuzzy_matches = fuzzify(alias)
    for _, key in ipairs(fuzzy_matches) do
      if not properties[key] then
        properties[key] = options
      end
    end
  end
end

M.Indexer = Indexer
M.new = function() return Indexer:new() end

return M