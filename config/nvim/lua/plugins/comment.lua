return {
    "terrortylor/nvim-comment",
    config = function()
        require("nvim_comment").setup({
            marker_padding = true,
            comment_empty = true,
            comment_empty_trim_whitespace = true,
            create_mappings = true,
            line_mapping = "gcc",    -- normal mode
            operator_mapping = "gc", -- visual mode
            comment_chunk_text_object = "ic",
            hook = nil,
        })
    end
}
