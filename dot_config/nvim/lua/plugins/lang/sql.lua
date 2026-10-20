local sql_ft = { 'sql' }

-- disable the built-in sql ftplugin's <C-c>-prefixed insert-mode mappings
vim.g.omni_sql_no_default_maps = 1

-- blink source for sql keywords (postgres_lsp and sqmeow only complete schema objects).
-- registered via package.preload so it can live in this file; blink loads sources by module name
-- stylua: ignore
local sql_keywords = {
  keywords = {
    'SELECT', 'DISTINCT', 'FROM', 'WHERE', 'AND', 'OR', 'NOT', 'IN', 'EXISTS', 'BETWEEN', 'LIKE', 'ILIKE',
    'IS', 'NULL', 'TRUE', 'FALSE', 'AS', 'ON', 'USING', 'JOIN', 'INNER JOIN', 'LEFT JOIN', 'RIGHT JOIN',
    'FULL JOIN', 'CROSS JOIN', 'LATERAL', 'GROUP BY', 'ORDER BY', 'HAVING', 'LIMIT', 'OFFSET', 'ASC', 'DESC',
    'NULLS FIRST', 'NULLS LAST', 'UNION', 'UNION ALL', 'INTERSECT', 'EXCEPT', 'WITH', 'RECURSIVE', 'CASE',
    'WHEN', 'THEN', 'ELSE', 'END', 'OVER', 'PARTITION BY', 'FILTER', 'INSERT INTO', 'VALUES', 'DEFAULT',
    'RETURNING', 'UPDATE', 'SET', 'DELETE FROM', 'ON CONFLICT', 'DO NOTHING', 'DO UPDATE', 'CREATE', 'TABLE',
    'VIEW', 'INDEX', 'ALTER', 'DROP', 'TRUNCATE', 'IF EXISTS', 'IF NOT EXISTS', 'PRIMARY KEY', 'FOREIGN KEY',
    'REFERENCES', 'UNIQUE', 'CHECK', 'CONSTRAINT', 'BEGIN', 'COMMIT', 'ROLLBACK', 'EXPLAIN', 'ANALYZE',
    -- postgres
    'DISTINCT ON', 'SIMILAR TO', 'IS DISTINCT FROM', 'IS NOT DISTINCT FROM', 'ANY', 'ALL', 'ARRAY',
    'INTERVAL', 'WITH ORDINALITY', 'WITHIN GROUP', 'WINDOW', 'ROWS BETWEEN', 'RANGE BETWEEN',
    'UNBOUNDED PRECEDING', 'UNBOUNDED FOLLOWING', 'CURRENT ROW', 'FETCH FIRST', 'ROWS ONLY', 'TABLESAMPLE',
    'FOR UPDATE', 'FOR SHARE', 'SKIP LOCKED', 'NOWAIT', 'MATERIALIZED', 'NOT MATERIALIZED', 'MERGE INTO',
    'WHEN MATCHED', 'WHEN NOT MATCHED', 'EXCLUDED', 'ON DELETE CASCADE', 'GENERATED ALWAYS AS IDENTITY',
    'CONCURRENTLY', 'MATERIALIZED VIEW', 'REFRESH MATERIALIZED VIEW', 'SCHEMA', 'SEQUENCE', 'EXTENSION',
    'FUNCTION', 'RETURNS', 'LANGUAGE', 'TRIGGER', 'TYPE', 'ENUM', 'DOMAIN', 'GRANT', 'REVOKE', 'COPY',
    'VACUUM', 'REINDEX', 'LISTEN', 'NOTIFY', 'SEARCH_PATH', 'EXPLAIN ANALYZE',
  },
  functions = {
    'COUNT', 'SUM', 'AVG', 'MIN', 'MAX', 'CAST', 'COALESCE', 'NULLIF', 'GREATEST', 'LEAST',
    -- postgres
    'ARRAY_AGG', 'STRING_AGG', 'JSON_AGG', 'JSONB_AGG', 'JSONB_OBJECT_AGG', 'BOOL_AND', 'BOOL_OR',
    'JSONB_BUILD_OBJECT', 'JSONB_BUILD_ARRAY', 'JSONB_SET', 'JSONB_ARRAY_ELEMENTS', 'JSONB_EACH',
    'JSONB_PRETTY', 'TO_JSONB', 'ROW_TO_JSON', 'UNNEST', 'GENERATE_SERIES', 'ARRAY_LENGTH', 'CARDINALITY',
    'ROW_NUMBER', 'RANK', 'DENSE_RANK', 'LAG', 'LEAD', 'FIRST_VALUE', 'LAST_VALUE', 'NTILE',
    'NOW', 'CURRENT_DATE', 'CURRENT_TIMESTAMP', 'DATE_TRUNC', 'DATE_PART', 'EXTRACT', 'AGE', 'TO_CHAR',
    'TO_DATE', 'TO_TIMESTAMP', 'LOWER', 'UPPER', 'LENGTH', 'TRIM', 'SUBSTRING', 'CONCAT', 'CONCAT_WS',
    'SPLIT_PART', 'REPLACE', 'REGEXP_REPLACE', 'REGEXP_MATCHES', 'LEFT', 'RIGHT', 'FORMAT', 'MD5',
    'GEN_RANDOM_UUID', 'PG_TYPEOF', 'PG_SIZE_PRETTY', 'PG_TOTAL_RELATION_SIZE', 'PG_CANCEL_BACKEND',
    'PG_TERMINATE_BACKEND',
  },
  types = {
    'SMALLINT', 'INTEGER', 'BIGINT', 'SERIAL', 'BIGSERIAL', 'NUMERIC', 'REAL', 'DOUBLE PRECISION', 'TEXT',
    'VARCHAR', 'CHAR', 'BOOLEAN', 'DATE', 'TIME', 'TIMESTAMP', 'TIMESTAMPTZ', 'UUID', 'JSON', 'JSONB',
    'BYTEA', 'INET', 'CIDR', 'TSVECTOR', 'INT4RANGE', 'TSTZRANGE',
  },
}

package.preload['sql_keywords.blink'] = function()
  local Source = {}

  function Source.new()
    return setmetatable({}, { __index = Source })
  end

  function Source:enabled()
    return vim.tbl_contains(sql_ft, vim.bo.filetype)
  end

  function Source:get_completions(ctx, callback)
    -- match the case of what's been typed: `sel` -> select, `Sel`/`SEL` -> SELECT
    local lower = ctx.get_keyword():match('^%l') ~= nil
    local kinds = require('blink.cmp.types').CompletionItemKind
    local group_kinds = { keywords = kinds.Keyword, functions = kinds.Function, types = kinds.TypeParameter }
    local items = {}
    for group, words in pairs(sql_keywords) do
      for _, word in ipairs(words) do
        items[#items + 1] = { label = lower and word:lower() or word, kind = group_kinds[group] }
      end
    end
    callback({ items = items, is_incomplete_backward = false, is_incomplete_forward = false })
  end

  return Source
end

return {
  {
    'nvim-treesitter/nvim-treesitter',
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { 'sql' })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        postgres_lsp = {
          -- also attach to scratch files outside a project with postgres-language-server.jsonc
          workspace_required = false,
        },
      },
    },
  },
  {
    'saghen/blink.cmp',
    optional = true,
    opts = {
      sources = {
        default = { 'sql_keywords', 'sqmeow' },
        providers = {
          sql_keywords = {
            name = 'SQL',
            module = 'sql_keywords.blink',
          },
          sqmeow = {
            name = 'Sqmeow',
            module = 'sqmeow.completion.blink',
            -- skip until :Sqmeow has loaded the plugin, so completion doesn't load it early
            enabled = function()
              return LazyVim.is_loaded('sqmeow.nvim') ~= nil
            end,
          },
        },
      },
    },
  },
  {
    'mason-org/mason.nvim',
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { 'sqlfluff' })
    end,
  },
  {
    'stevearc/conform.nvim',
    optional = true,
    opts = function(_, opts)
      opts.formatters = opts.formatters or {}
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters.sqlfluff = {
        args = { 'format', '--dialect=ansi', '-' },
      }
      for _, ft in ipairs(sql_ft) do
        opts.formatters_by_ft[ft] = opts.formatters_by_ft[ft] or {}
        table.insert(opts.formatters_by_ft[ft], 'sqlfluff')
      end
    end,
  },
  {
    'mfussenegger/nvim-lint',
    optional = true,
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}
      for _, ft in ipairs(sql_ft) do
        opts.linters_by_ft[ft] = opts.linters_by_ft[ft] or {}
        table.insert(opts.linters_by_ft[ft], 'sqlfluff')
      end
    end,
  },
}
