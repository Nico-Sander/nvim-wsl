-- Easier switching to normal mode from terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>")

-- Autocommand that runs when trying to leave nvim. Force-closes all terminal buffers, so nvim can exit.
vim.api.nvim_create_autocmd("ExitPre", {
    pattern = "*",
    callback = function()
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_get_option_value("buftype", { buf = buf }) == "terminal" then
                vim.api.nvim_buf_delete(buf, { force = true })
            end
        end
    end,
})

-- Keep track of existing terminal buffers to be able to reuse them
local state = {
    floating = {
        buf = -1,
        win = -1,
    },
}

local function create_floating_window(opts)
    opts = opts or {}
    -- Calculate the dimensions of the window
    local width = opts.width or math.floor(vim.o.columns * 0.8)
    local height = opts.height or math.floor(vim.o.lines * 0.8)

    -- Calculate the position to center the window
    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)

    -- Create a buffer
    local buf = nil
    -- If an already existing buffer was provided in the opts, then reuse this buffer
    if vim.api.nvim_buf_is_valid(opts.buf) then
        buf = opts.buf
    -- If no buffer was provided in the opts, then create a new empty buffer
    else
        buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
    end

    -- Define window configuration
    local win_config = {
        relative = "editor",
        width = width,
        height = height,
        col = col,
        row = row,
        style = "minimal",
        border = "rounded",
        title = "Terminal",
        title_pos = "center",
    }

    -- Create the floating window
    local win = vim.api.nvim_open_win(buf, true, win_config)

    return { buf = buf, win = win }
end

-- Example usage
-- Create a floating window with default dimensions
local toggle_terminal = function()
    -- if the floating terminal isnt currently open: create a new window, and reuse existing floating terminal buffers
    if not vim.api.nvim_win_is_valid(state.floating.win) then
        state.floating = create_floating_window({ buf = state.floating.buf })
        -- if the type of the buffer isn't "terminal": set the type to terminal
        if vim.bo[state.floating.buf].buftype ~= "terminal" then
            vim.cmd.terminal()
        end
        vim.cmd.startinsert()
    -- if the floating terminal is currently oopen: hide the window
    else
        vim.api.nvim_win_hide(state.floating.win)
    end
    -- print(vim.inspect(state.floating))
end

-- Create a command called ":Floaterminal" so that it can be used
vim.api.nvim_create_user_command("Floaterminal", toggle_terminal, {})
vim.keymap.set({ "n", "t" }, "<space>tt", toggle_terminal)
