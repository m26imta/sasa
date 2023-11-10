local M = {}

local is_array = function(tbl)
  local _cache = {}
  local count = #tbl
  if count == 0 then
    return false
  end

  for i=1,count do
    local v = tbl[i]
    if v == nil then
      return false
    end
    tbl[i] = nil
    _cache[i] = v
  end

  if next(tbl) then
    return false
  end

  for i=1,count do
    tbl[i] = _cache[i]
    _cache[i] = nil
  end

  return true
end

local merge_array = function(arr1, arr2)
  for _,v in ipairs(arr2) do
    if v then
      table.insert(arr1, v)
    end
  end
  return arr1
end

local merge_tbl = function(tbl1, tbl2)
  return vim.tbl_deep_extend("force", tbl1, tbl2)
end

M.merge_tbl = function(tbl1, tbl2)
  if is_array(tbl1) and is_array(tbl2) then
    return merge_array(tbl1, tbl2)
  else
    return merge_tbl(tbl1, tbl2)
  end
end

M.is_array = is_array

return M
