local chad_modules = {
    "options",
    "mappings",
    "utils"
}
for i = 1, #chad_modules, 1 do
    pcall(require, chad_modules[i])
end
--TODO: investigate if TS imports works *yes
--TODO: add nvim-dap/dap telescope
--TODO: add the telescope methods. investigate how to add more pwoerfule ones
-- TODO: octo?
--TODO: add wilder
--TODO: once done have a last look at the old files before pushing.
-- double check neoformat works for svelte https://github.com/sbdchd/neoformat
-- TODO: add the required global installs to manjaro install

