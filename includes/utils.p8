pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
function log(msg)
    if DEBUG then
        printh(msg, "log.txt")
    end
end

function table_to_string(t, depth)
    depth = depth or 0
    if depth > 5 then return "{...}" end
    -- prevent infinite recursion

    local indent = ""
    for i = 1, depth do
        indent = indent .. "  "
    end

    local result = "{\n"
    for k, v in pairs(t) do
        result = result .. indent .. "  "
        -- handle key
        if type(k) == "number" then
            result = result .. "[" .. k .. "]="
        else
            result = result .. k .. "="
        end
        -- handle value
        if type(v) == "table" then
            result = result .. table_to_string(v, depth + 1)
        elseif type(v) == "number" then
            result = result .. v
        elseif type(v) == "boolean" then
            result = result .. (v and "true" or "false")
        elseif type(v) == "function" then
            result = result .. "function"
        else
            result = result .. '"' .. v .. '"'
        end
        result = result .. ",\n"
    end
    return result .. indent .. "}"
end
