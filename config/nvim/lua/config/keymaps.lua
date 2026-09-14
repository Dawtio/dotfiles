local map = vim.keymap.set

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- new file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- windows
map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })

-- Gitsigns 
map("n", "<leader>gB", "<cmd>Gitsigns toggle_current_line_blame<CR>", { desc = "Show git blame" })
map("n", "<leader>gn", "<cmd>Gitsigns toggle_linehl<CR>",             { desc = "Toogle diff line" })

-- Formatting
map("n", "<leader>cf", function() require("conform").format() end, { desc = "Format file" })

-- SNACKS
-- -- Top Pickers & Explorer
map("n", "<leader>:", function() Snacks.picker.command_history() end,                                                { desc = "Command History" })
map("n", "<leader>n", function() Snacks.picker.notifications({ on_show = function() vim.cmd.stopinsert() end,}) end, { desc = "Notification History" })
map("n", "<leader>e", function() Snacks.explorer() end,                                                              { desc = "File Explorer" })
-- -- Find
map("n", "<leader>fb", function() Snacks.picker.buffers({
  on_show = function() vim.cmd.stopinsert() end,
  win = {
    input = {
      keys = {["d"] = "bufdelete" },
    },
    list = {
      keys = { ["d"] = "bufdelete" }
    }
  }
}) end, { desc = "Buffers" })
map("n", "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, { desc = "Find Config File" })
map("n", "<leader>ff", function() Snacks.picker.files() end,                                   { desc = "Find Files" })
map("n", "<leader>fg", function() Snacks.picker.git_files() end,                               { desc = "Find Git Files" })
map("n", "<leader>fp", function()
  local root = vim.fn.expand("~/projects")

  local function is_project(dir)
    return vim.fn.isdirectory(dir .. "/.git") == 1
      or vim.fn.filereadable(dir .. "/README.md") == 1
  end

  local function find_projects(dir, depth)
    local results = {}
    local entries = vim.fn.glob(dir .. "/*/", false, true)
    for _, entry in ipairs(entries) do
      entry = entry:gsub("/$", "")
      if is_project(entry) then
        table.insert(results, entry)
      elseif depth > 1 then
        vim.list_extend(results, find_projects(entry, depth - 1))
      end
    end
    return results
  end

  local items = {}
  for i, dir in ipairs(find_projects(root, 2)) do
    table.insert(items, {
      idx  = i,
      text = dir:gsub(root .. "/", ""), -- show relative path, e.g. "work/project-a"
      file = dir,
    })
  end

  Snacks.picker({
    title = "Projects",
    finder = function() return items end,
    on_show = function() vim.cmd.stopinsert() end,
    confirm = function(picker, item)
      picker:close()
      if item then
        vim.fn.chdir(item.file)
        vim.notify("󰉖  " .. item.text, vim.log.levels.INFO)
      end
    end,
  })
end, { desc = "Pick project (~/projects)" })



map("n", "<leader>fr", function() Snacks.picker.recent() end, { desc = "Recent" })
-- -- Git
map("n", "<leader>gb", function() Snacks.picker.git_branches() end, { desc = "Git Branches" })
map("n", "<leader>gs", function() Snacks.picker.git_status() end,   { desc = "Git Status" })
map("n", "<leader>gS", function() Snacks.picker.git_stash() end,    { desc = "Git Stash" })
map("n", "<leader>gd", function() Snacks.picker.git_diff() end,     { desc = "Git Diff (Hunks)" })
-- -- Lazygit
map("n", "<leader>gg", function() Snacks.lazygit.open() end,     { desc = "Opens Lazygit" })
map("n", "<leader>gl", function() Snacks.lazygit.log() end,      { desc = "Opens Lazygit with the log view" })
map("n", "<leader>gL", function() Snacks.lazygit.log_file() end, { desc = "Opens Lazygit with the log of the current file" })
-- -- gh
map("n", "<leader>gi", function() Snacks.picker.gh_issue() end,                  { desc = "GitHub Issues (open)" })
map("n", "<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end, { desc = "GitHub Issues (all)" })
map("n", "<leader>gp", function() Snacks.picker.gh_pr() end,                     { desc = "GitHub Pull Requests (open)" })
map("n", "<leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end,    { desc = "GitHub Pull Requests (all)" })
-- -- Grep
map("n", "<leader>sB", function() Snacks.picker.grep_buffers() end,       { desc = "Grep Open Buffers" })
map("n", "<leader>sg", function() Snacks.picker.grep() end,               { desc = "Grep" })
map({ "n", "x" }, "<leader>sw", function() Snacks.picker.grep_word() end, { desc = "Visual selection or word" })
-- -- Search
map("n", '<leader>s"', function() Snacks.picker.registers({ on_show = function() vim.cmd.stopinsert() end,}) end, { desc = "Registers" })
map("n", '<leader>s/', function() Snacks.picker.search_history() end,                                             { desc = "Search History" })
map("n", "<leader>sa", function() Snacks.picker.autocmds() end,                                                   { desc = "Autocmds" })
map("n", "<leader>sb", function() Snacks.picker.lines() end,                                                      { desc = "Buffer Lines" })
map("n", "<leader>sc", function() Snacks.picker.command_history() end,                                            { desc = "Command History" })
map("n", "<leader>sC", function() Snacks.picker.commands() end,                                                   { desc = "Commands" })
map("n", "<leader>sd", function() Snacks.picker.diagnostics() end,                                                { desc = "Diagnostics" })
map("n", "<leader>sD", function() Snacks.picker.diagnostics_buffer() end,                                         { desc = "Buffer Diagnostics" })
map("n", "<leader>sh", function() Snacks.picker.help() end,                                                       { desc = "Help Pages" })
map("n", "<leader>sH", function() Snacks.picker.highlights() end,                                                 { desc = "Highlights" })
map("n", "<leader>si", function() Snacks.picker.icons() end,                                                      { desc = "Icons" })
map("n", "<leader>sj", function() Snacks.picker.jumps() end,                                                      { desc = "Jumps" })
map("n", "<leader>sk", function() Snacks.picker.keymaps() end,                                                    { desc = "Keymaps" })
map("n", "<leader>sl", function() Snacks.picker.loclist() end,                                                    { desc = "Location List"})
map("n", "<leader>sm", function() Snacks.picker.marks() end,                                                      { desc = "Marks" })
map("n", "<leader>sM", function() Snacks.picker.man() end,                                                        { desc = "Man Pages" })
map("n", "<leader>sp", function() Snacks.picker.lazy() end,                                                       { desc = "Search for Plugin Spec" })
map("n", "<leader>sR", function() Snacks.picker.resume() end,                                                     { desc = "Resume" })
map("n", "<leader>su", function() Snacks.picker.undo() end,                                                       { desc = "Undo History" })
map("n", "<leader>st", function() Snacks.picker.todo_comments() end,                                              { desc = "Todo/Fix/Bug" })
map("n", "<leader>uc", function() Snacks.picker.colorschemes() end,                                               { desc = "Colorschemes" })
-- -- Terminal
map("n", "<c-/>", function() Snacks.terminal.focus("zsh", { cwd = vim.fn.getcwd() }) end, { desc = "Toogle Terminal" })

-- OpenCode server
map("n", "<leader>ac", function()
  Snacks.terminal.open("opencode --port", { win = { position = "right" }, cwd = vim.fn.getcwd() })
end, { desc = "Open OpenCode server" })

-- LSP (only active when a language server attaches to the buffer
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local mappy = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    mappy("gd",          vim.lsp.buf.definition,     "Go to Definition")
    mappy("gD",          vim.lsp.buf.declaration,    "Go to Declaration")
    mappy("gr",          vim.lsp.buf.references,     "Go to References")
    mappy("gi",          vim.lsp.buf.implementation, "Go to Implementation")
    mappy("K",           vim.lsp.buf.hover,          "Hover Documentation")
    mappy("<leader>cr",  vim.lsp.buf.rename,         "Rename Symbol")
    mappy("<leader>ca",  vim.lsp.buf.code_action,    "Code Action")
    mappy("<leader>cd",  vim.diagnostic.open_float,  "Line Diagnostics")
    mappy("[d", function() vim.diagnostic.jump({ count = -1 }) end, "Prev Diagnostic")
    mappy("]d", function() vim.diagnostic.jump({ count =  1 }) end, "Next Diagnostic")
  end,
})

-- OpenCode
map({ "n", "x" }, "<C-a>",   function() require("opencode").ask("@this: ") end,                    { desc = "Ask OpenCode…" })
map({ "n", "x" }, "<C-x>",   function() require("opencode").select() end,                          { desc = "Select OpenCode…" })
map({ "n", "x" }, "go",      function() return require("opencode").operator("@this ") end,         { desc = "Append range to OpenCode", expr = true })
map({ "n" },      "goo",     function() return require("opencode").operator("@this ") .. "_" end,  { desc = "Append line to OpenCode", expr = true })
map({ "n" },      "<S-C-u>", function() require("opencode").command("session.half.page.up") end,   { desc = "Scroll OpenCode up" })
map({ "n" },      "<S-C-d>", function() require("opencode").command("session.half.page.down") end, { desc = "Scroll OpenCode down" })

