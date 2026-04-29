return {
    setup = function(key)
        -- TODO save and restore cursor position. this is non-trivial
        function HexedToggle()
            if vim.b.hexed then
                vim.cmd("%!xxd -r")
                vim.cmd("filetype detect")
            else
                vim.cmd("%!xxd")
                vim.cmd("set syntax=hexed")
            end
            vim.b.hexed = not vim.b.hexed
        end

        vim.api.nvim_create_user_command(
            "HexedToggle",
            HexedToggle,
            { desc = "toggle if the buffer is viewed as hex." }
        )
        if key then
            vim.keymap.set("n", key, HexedToggle, { desc = "view hex" })
        end
    end
}
