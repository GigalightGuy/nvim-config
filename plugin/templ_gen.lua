local api = vim.api

function gen_header_guards(filename)
  local name = string.upper(filename)
  name = "_" .. string.gsub(name, "%W", "_") .. "_"
  api.nvim_buf_set_lines(0, 0, 0, true, {
    "#if !defined " .. name,
    "#define " .. name,
    "",
  })
  api.nvim_buf_set_lines(0, -1, -1, true, {
    "",
    "#endif // " .. name,
    })
end

-- Generate header guards for .h and .hpp files
api.nvim_create_autocmd("BufNewFile", {
  pattern = {"*.h", "*.hpp"},
  callback = function(ev)
    gen_header_guards(ev.file)
  end
})
