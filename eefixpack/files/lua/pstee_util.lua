-- split string "str" around matches of character "sep"
function split(str, sep)
  local s, t = sep or '%s', {}
  for m in string.gmatch(str, '([^' .. s .. ']+)') do
    table.insert(t, m)
  end
  return t
end
