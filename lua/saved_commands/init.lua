local storage = require("saved_commands.storage")
local picker = require("saved_commands.picker")
local form = require("saved_commands.form")
local template = require("saved_commands.template")

local M = {}

M.CONFIG_FILE = storage.CONFIG_FILE
M.load_commands = storage.load_commands
M.save_command = storage.save_command
M.open_picker = picker.open_picker
M.open_create_form = form.open_create_form
M.apply_template = template.apply_template

return M
