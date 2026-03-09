local M = {}

local MATH_NODES = {
    displayed_equation = true,
    inline_formula = true,
    math_environment = true,
    latex_block = true,
}

local TEXT_NODES = {
    text_mode = true,
    label_definition = true,
    label_reference = true,
}

local CODE_BLOCK_NODES = { -- Add this to define code block node types
    fenced_code_block = true,
    indented_code_block = true, -- Optional: include indented code blocks as well if needed
}

function M.in_text(check_parent)
    local node = vim.treesitter.get_node({ ignore_injections = false })
    
    -- Check for code blocks in any filetype
    local block_node = node
    while block_node do
        if CODE_BLOCK_NODES[block_node:type()] then
            return true -- If in a code block, always consider it text
        end
        block_node = block_node:parent()
    end

    while node do
        if node:type() == "text_mode" then
            if check_parent then
                -- For \text{}
                local parent = node:parent()
                if parent and MATH_NODES[parent:type()] then
                    return false
                end
            end
            return true
        elseif MATH_NODES[node:type()] then
            return false
        end
        node = node:parent()
    end
    return true
end

function M.in_mathzone()
    local node = vim.treesitter.get_node({ ignore_injections = false })
    local current_filetype = vim.bo.filetype

    if current_filetype == "markdown" or current_filetype == "quarto" then
        local block_node = node
        while block_node do
            if CODE_BLOCK_NODES[block_node:type()] then
                return false
            end
            block_node = block_node:parent()
        end
    end

    while node do
        if TEXT_NODES[node:type()] then
            return false
        end

        if MATH_NODES[node:type()] then
            return true
        end
        
        -- Special handling for injected language root (source_file)
        -- If we reach the root of the injected language (source_file) without finding a math node
        -- and its parent is nil, it means the entire injected content *is* the math block.
        -- This happens when the outer markdown parser recognizes a block and injects a latex parser.
        if node:type() == "source_file" and not node:parent() then
             return true
        end

        node = node:parent()
    end
    return false
end

return M
