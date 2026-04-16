local Hooks = require 'git-worktree.hooks'
local config = require 'git-worktree.config'
local update_on_switch = Hooks.builtins.update_current_buffer_on_switch

Hooks.register(Hooks.type.SWITCH, function(path, prev_path)
  print('Switched from ' .. prev_path .. ' to ' .. path)
  local isHubApp = string.find(path, 'wearable%-hub%-application')
  if not isHubApp then
    return
  end
  print('Is Hub app : ', isHubApp)
  os.execute('sd "' .. prev_path .. '" "' .. path .. '" /home/krv/projects/hub-tools/testrunner/.testrunner_settings.json')
  local f = assert(io.open('/home/krv/worktree_env.sh', 'w'))
  if f then
    local lines = {
      '#!/usr/bin/env bash',
      'WORK_TREE_PATH=' .. path,
      "WORK_TREE=$(echo ${WORK_TREE_PATH} | awk -F '/' '{print $NF}')",
      'export HUBAPP_DIR=${WORK_TREE}',
    }
    local content = table.concat(lines, '\n')
    f:write(content)
    f:close()
  else
    print 'Error opening file ! ~/worktree_env.sh'
  end
end)
