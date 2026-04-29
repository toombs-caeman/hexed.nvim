return {
    setup = function(key)
        -- TODO save and restore cursor position.
        -- use the offset markers in hexed mode to
        -- this is non-trivial. see how others do this
        function HexedToggle()
            -- before anything else, grab the current cursor position
            local pos = vim.fn.getpos('.')
            -- switch to 0-based indexing for easier modular arithmetic
            local lnum, col = pos[2] - 1, pos[3] - 1
            local debug = {pos = pos, lnum = lnum, col = col, hexed = vim.b.hexed}
            -- TODO using a variable here doesn't work because it doesn't support undo/redo
            if vim.b.hexed then
                -- modify buffer and highlighting
                vim.cmd("syn clear")
                vim.cmd("%!xxd -r")
                vim.cmd("filetype detect")
                -- calc cursor offset
                -- xxd puts 16 bytes on a line
                local offset = 16 * lnum
                if col > 51 then
                    debug.section = 'comment'
                    -- we're in the comment column
                    -- which is 1-1 to the unhexed output
                    offset = offset + col - 52
                    debug.byte = col - 52
                    debug.high = 0
                elseif col < 10 then
                    -- we're in the offset marker
                    -- don't put any column offset
                    debug.section = 'offset'
                    debug.chunk = 0
                    debug.high = 0
                else
                    -- we're in the data section
                    -- each chunk is a space followed by two hex bytes
                    -- ' 1234'
                    debug.section = 'data'
                    local chunk = math.floor((col - 10) / 5)
                    local high = (col % 5) >= 2 and 1 or 0
                    offset = offset + 2 * chunk + high
                    debug.chunk = chunk
                    debug.high = high
                end
                debug.offset = offset
                -- goto new position
                vim.cmd("goto "..offset + 1)
            else
                -- calculate new position
                -- the current byte offset
                local offset = vim.fn.line2byte(lnum)+col+1
                -- xxd puts 16 bytes on a line
                local outlnum = math.floor(offset / 16)
                local outchar = (offset % 16)
                local outcol = 10 + 2 * (outchar % 2) + 5*math.floor(outchar / 2)
                -- modify buffer and highlighting
                vim.cmd("filetype off")
                vim.cmd("%!xxd")
                vim.cmd("set syntax=hexed")
                -- move cursor to the calculated offset
                vim.fn.cursor(outlnum+1,outcol+1)
                debug.offset = offset
                debug.outlnum = outlnum + 1
                debug.outcol = outcol + 1
                debug.outchar = outchar
            end
            vim.b.hexed = not vim.b.hexed
            -- require('mini.misc').put(debug)
        end

        vim.api.nvim_create_user_command(
            "HexedToggle",
            HexedToggle,
            { desc = "toggle if the buffer is viewed as hex." }
        )
        if key then
            vim.keymap.set("n", key, HexedToggle, { desc = "view buffer as hex" })
        end
    end
}
