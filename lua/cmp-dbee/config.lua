local config = {}

--- @class Config
--- @field suggestions SuggestionsCfg
--- @field connection ConnectionCfg
--- @field cmp_menu CmpMenuCfg

---@class SuggestionsCfg
---@field lazy_columns boolean
---@field flatten_structure boolean
---@field built_in_keywords boolean
---@field quotes boolean

---@class ConnectionCfg
---@field timeout_ms number

---@class CmpMenuCfg
---@field schema CmpMenuItemCfg
---@field table CmpMenuItemCfg
---@field view CmpMenuItemCfg

---@class CmpMenuItemCfg
---@field title string
---@field icon string
---@field hl string

config.default = {
  suggestions = {
    lazy_columns = true, -- lazy loading of columns using alias ref
    flatten_structure = true, -- flatten structure for completion (schema+table)
    built_in_keywords = true, -- suggest built-in keywords (do people want to add their own?)
    quotes = false, -- add quotes around completion items
  },
  connection = {
    timeout_ms = 1000, -- timeout for any calls to dbee API
  },
  -- TODO: extend with more options
  cmp_menu = {
    schema = {
      kind_text = "Constructor",
      icon = "",
      kind_hl_group = "Constructor",
    },
    table = {
      kind_text = "Struct",
      icon = "ﰲ",
      kind_hl_group = "Struct",
    },
    view = {
      kind_text = "Interface",
      icon = "ﰲ",
      kind_hl_group = "Interface",
    },
    columns = {
      kind_text = "Field",
      icon = "ﰲ",
      kind_hl_group = "Field",
    },
    keyword = {
      kind_text = "Keyword",
      icon = "",
      kind_hl_group = "Keyword",
    },
    alias = {
      kind_text = "Reference",
      icon = "",
      kind_hl_group = "Constructor",
    },
    cte = {
      kind_text = "EnumMember",
      icon = "",
      kind_hl_group = "Constructor",
    },
  },
}

--- Validate the configuration
---@param cfg Config
---@return boolean
function config.validate(cfg)
  assert(type(cfg) == "table", "config must be a table")
  assert(cfg.connection, "config.connection must be a table")
  assert(cfg.suggestions, "config.suggestions must be a table")
  assert(cfg.cmp_menu, "config.cmp_menu must be a table")

  return true
end

---  Merge user configuration with defaults
---@param user_cfg Config?
---@return Config
function config.merge_defaults(user_cfg)
  user_cfg = user_cfg or {}
  return vim.tbl_deep_extend("force", config.default, user_cfg)
end

return config
