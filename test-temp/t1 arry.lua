local unpack = table.unpack

a = {1, 2, 3}
b = {4, 5, 6}

-- for _, v in pairs(b) do
--     table.insert(a, v)
-- end


c = {1, 2, 3, unpack(b)}


print(table.concat(c, ", "))