-- Apex LSP Setup Helper
-- This module helps find and configure the Salesforce Apex Language Server

local M = {}

-- Possible locations for the Apex Language Server JAR file
local apex_lsp_paths = {
  -- VS Code extension path (macOS)
  vim.fn.glob('~/.vscode/extensions/salesforce.salesforcedx-vscode-apex-*/out/apex-jorje-lsp.jar'),
  -- VS Code extension path (alternative location)
  vim.fn.glob('~/Library/Application Support/Code/User/extensions/salesforce.salesforcedx-vscode-apex-*/out/apex-jorje-lsp.jar'),
  -- VSCodium path
  vim.fn.glob('~/.vscode-oss/extensions/salesforce.salesforcedx-vscode-apex-*/out/apex-jorje-lsp.jar'),
  -- Manual installation path
  vim.fn.expand('~/apex-language-server/apex-jorje-lsp.jar'),
  -- System-wide installation
  '/usr/local/lib/apex-jorje-lsp.jar',
  -- Homebrew installation (if available)
  '/opt/homebrew/lib/apex-jorje-lsp.jar',
}

-- Find the first existing JAR file
function M.find_apex_jar()
  for _, path in ipairs(apex_lsp_paths) do
    if path ~= '' and vim.fn.filereadable(path) == 1 then
      return path
    end
  end
  return nil
end

-- Get the command to run the Apex Language Server
function M.get_apex_cmd()
  local jar_path = M.find_apex_jar()
  
  if not jar_path then
    vim.notify([[
Apex Language Server JAR not found!

To install it, you have several options:

1. Install the Salesforce Extensions for VS Code:
   - Install VS Code
   - Install the Salesforce Extension Pack from the marketplace
   - The JAR will be in ~/.vscode/extensions/salesforce.salesforcedx-vscode-apex-*/out/

2. Download manually from Salesforce:
   - Install Salesforce CLI: brew install sf
   - Extract the JAR from the Salesforce tools

3. Copy from an existing installation:
   - Place apex-jorje-lsp.jar in ~/apex-language-server/

After installation, restart Neovim.
]], vim.log.levels.WARN)
    return nil
  end
  
  return {
    'java',
    '-cp', jar_path,
    '-Ddebug.internal.errors=true',
    '-Ddebug.semantic.errors=false', 
    '-Ddebug.completion.statistics=false',
    '-Dlwc.typegeneration.disabled=true',
    'apex.jorje.lsp.ApexLanguageServerLauncher'
  }
end

return M