
local ok, mod = pcall(require, 'orgmode')
if ok then
    mod.setup {
        org_agenda_files = {'~/org/*'},
        org_default_notes_file = '~/org/refile.org',
        org_todo_keywords = { 'TODO(t)', '|', 'DONE(d)'},
    }
end
