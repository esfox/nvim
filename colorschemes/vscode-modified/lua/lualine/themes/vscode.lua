-- Copyright (c) 2020-2021 Mofiqul Islam
-- MIT license, see LICENSE for more details.
local vscode = {}
local colors = {
    inactive = '#666666',
    bg = '#303030',
    bg2 = '#404040',
    fg = '#d0d0d0',
    red = '#f44747',
    green = '#81c784',
    blue = '#569CD6',
    lightblue = '#5CB6F8',
    yellow = '#ffb74d',
    pink = '#DDB6F2',
}


vscode.normal = {
    a = { fg = vim.o.background == 'dark' and colors.bg or colors.bg, bg = colors.green, gui = 'bold' },
    b = { fg = colors.fg, bg = colors.bg2 },
    c = { fg = colors.fg, bg = colors.bg },
}

vscode.visual = {
    a = { fg = colors.bg, bg = colors.yellow, gui = 'bold' },
    b = { fg = colors.fg, bg = colors.bg2 },
}

vscode.inactive = {
    a = { fg = colors.fg, bg = colors.bg, gui = 'bold' },
    b = { fg = colors.inactive, bg = colors.bg },
    c = { fg = colors.inactive, bg = colors.bg },
}

vscode.replace = {
    a = { fg = vim.o.background == 'dark' and colors.bg or colors.fg, bg = colors.red, gui = 'bold' },
    b = { fg = colors.fg, bg = colors.bg2 },
    c = { fg = colors.fg, bg = colors.bg },
}

vscode.insert = {
    a = { fg = vim.o.background == 'dark' and colors.bg or colors.fg, bg = colors.blue, gui = 'bold' },
    b = { fg = colors.fg, bg = colors.bg2 },
    c = { fg = colors.fg, bg = colors.bg },
}

vscode.terminal = {
    a = { fg = vim.o.background == 'dark' and colors.bg or colors.fg, bg = colors.green, gui = 'bold' },
    b = { fg = colors.fg, bg = colors.bg2 },
    c = { fg = colors.fg, bg = colors.bg },
}

vscode.command = {
    a = { fg = vim.o.background == 'dark' and colors.bg or colors.fg, bg = colors.pink, gui = 'bold' },
    b = { fg = colors.pink, bg = colors.bg2 },
    c = { fg = colors.fg, bg = colors.bg },
}

return vscode
