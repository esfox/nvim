local hl = vim.api.nvim_set_hl
local theme = {}

theme.set_highlights = function(opts)
    local c = require('vscode.colors').get_colors()
    c = vim.tbl_extend('force', c, opts['color_overrides'])
    local isDark = true

    hl(0, 'Normal', { fg = c.vscFront, bg = c.vscBack })
    hl(0, 'ColorColumn', { fg = 'NONE', bg = c.bg3 })
    hl(0, 'Cursor', { fg = c.vscCursorDark, bg = c.vscCursorLight })
    hl(0, 'CursorLine', { bg = c.vscCursorDarkDark })
    hl(0, 'CursorColumn', { fg = 'NONE', bg = c.vscCursorDarkDark })
    hl(0, 'Directory', { fg = c.vscBlue, bg = c.vscBack })
    hl(0, 'DiffAdd', { fg = 'NONE', bg = c.vscDiffGreenLight })
    hl(0, 'DiffChange', { fg = 'NONE', bg = c.vscDiffRedDark })
    hl(0, 'DiffDelete', { fg = 'NONE', bg = c.vscDiffRedLight })
    hl(0, 'DiffText', { fg = 'NONE', bg = c.vscDiffRedLight })
    hl(0, 'EndOfBuffer', { fg = c.vscBack, bg = 'NONE' })
    hl(0, 'ErrorMsg', { fg = c.vscRed, bg = c.vscBack })
    hl(0, 'VertSplit', { fg = c.vscSplitDark, bg = c.vscBack })
    hl(0, 'Folded', { fg = 'NONE', bg = c.vscFoldBackground })
    hl(0, 'FoldColumn', { fg = c.vscLineNumber, bg = c.vscBack })
    hl(0, 'SignColumn', { fg = 'NONE', bg = c.vscBack })
    hl(0, 'IncSearch', { fg = c.vscNone, bg = c.vscSearchCurrent })
    hl(0, 'LineNr', { fg = c.vscLineNumber, bg = c.vscBack })
    hl(0, 'CursorLineNr', { fg = c.vscPopupFront, bg = c.vscBack })
    hl(0, 'MatchParen', { fg = c.yellow, bg = c.vscCursorDark, underline = true })
    hl(0, 'ModeMsg', { fg = c.vscFront, bg = c.vscLeftDark })
    hl(0, 'MoreMsg', { fg = c.vscFront, bg = c.vscLeftDark })
    hl(0, 'NonText', { fg = (isDark and c.vscLineNumber or c.vscTabOther), bg = c.vscNone })
    hl(0, 'Pmenu', { fg = c.vscPopupFront, bg = c.vscPopupBack })
    hl(0, 'PmenuSel', { fg = isDark and c.vscPopupFront or c.vscBack, bg = c.vscSelection })
    hl(0, 'PmenuSbar', { fg = 'NONE', bg = c.vscPopupHighlightGray })
    hl(0, 'PmenuThumb', { fg = 'NONE', bg = c.vscPopupFront })
    hl(0, 'Question', { fg = c.vscBlue, bg = c.vscBack })
    hl(0, 'Search', { fg = c.vscNone, bg = c.vscSearch })
    hl(0, 'SpecialKey', { fg = c.vscBlue, bg = c.vscNone })
    hl(0, 'StatusLine', { fg = c.vscFront, bg = c.vscLeftMid })
    hl(0, 'StatusLineNC', { fg = c.vscFront, bg = c.vscLeftDark })
    hl(0, 'TabLine', { fg = c.vscFront, bg = c.vscTabOther })
    hl(0, 'TabLineFill', { fg = c.vscFront, bg = c.vscTabOutside })
    hl(0, 'TabLineSel', { fg = c.vscFront, bg = c.vscTabCurrent })
    hl(0, 'Title', { fg = c.vscNone, bg = c.vscNone, bold = true })
    hl(0, 'Visual', { fg = c.vscNone, bg = c.vscSelection })
    hl(0, 'VisualNOS', { fg = c.vscNone, bg = c.vscSelection })
    hl(0, 'WarningMsg', { fg = c.vscRed, bg = c.vscBack, bold = true })
    hl(0, 'WildMenu', { fg = c.vscNone, bg = c.vscSelection })
    hl(0, 'Comment', { fg = c.vscGreen, bg = 'NONE', italic = opts.italic_comments })
    hl(0, 'Constant', { fg = c.green, bg = 'NONE' })
    hl(0, 'String', { fg = c.yellow, bg = 'NONE' })
    hl(0, 'Character', { fg = c.yellow, bg = 'NONE' })
    hl(0, 'Number', { fg = c.vscLightGreen, bg = 'NONE' })
    hl(0, 'Boolean', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, 'Float', { fg = c.vscLightGreen, bg = 'NONE' })
    hl(0, 'Identifier', { fg = c.green, bg = 'NONE' })
    hl(0, 'Function', { fg = c.brown, bg = 'NONE' })
    hl(0, 'Statement', { fg = c.blue, bg = 'NONE' })
    hl(0, 'Conditional', { fg = c.red, bg = 'NONE' })
    hl(0, 'Repeat', { fg = c.red, bg = 'NONE' })
    hl(0, 'Label', { fg = c.blue, bg = 'NONE' })
    hl(0, 'Operator', { fg = c.vscFront, bg = 'NONE' })
    hl(0, 'Keyword', { fg = c.bluo, bg = 'NONE' })
    hl(0, 'Exception', { fg = c.red, bg = 'NONE' })
    hl(0, 'PreProc', { fg = c.blue, bg = 'NONE' })
    hl(0, 'Include', { fg = c.red, bg = 'NONE' })
    hl(0, 'Define', { fg = c.blue, bg = 'NONE' })
    hl(0, 'Macro', { fg = c.blue, bg = 'NONE' })
    hl(0, 'Type', { fg = c.orange, bg = 'NONE' })
    hl(0, 'StorageClass', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, 'Structure', { fg = c.yellow_green, bg = 'NONE' })
    hl(0, 'Typedef', { fg = c.orange, bg = 'NONE' })
    hl(0, 'Special', { fg = c.yellow_orange, bg = 'NONE' })
    hl(0, 'SpecialChar', { fg = c.vscFront, bg = 'NONE' })
    hl(0, 'Tag', { fg = c.vscFront, bg = 'NONE' })
    hl(0, 'Delimiter', { fg = c.vscFront, bg = 'NONE' })
    hl(0, 'SpecialComment', { fg = c.gray, bg = 'NONE' })
    hl(0, 'Debug', { fg = c.vscFront, bg = 'NONE' })
    hl(0, 'Underlined', { fg = c.vscNone, bg = 'NONE', underline = true })
    hl(0, 'Conceal', { fg = c.vscFront, bg = c.vscBack })
    hl(0, 'Ignore', { fg = c.vscFront, bg = 'NONE' })
    hl(0, 'Error', { fg = c.vscRed, bg = c.vscBack, undercurl = true, sp = c.vscRed })
    hl(0, 'Todo', { fg = c.yellow_orange, bg = c.vscBack, bold = true })
    hl(0, 'SpellBad', { fg = c.vscRed, bg = c.vscBack, undercurl = true, sp = c.vscRed })
    hl(0, 'SpellCap', { fg = c.vscRed, bg = c.vscBack, undercurl = true, sp = c.vscRed })
    hl(0, 'SpellRare', { fg = c.vscRed, bg = c.vscBack, undercurl = true, sp = c.vscRed })
    hl(0, 'SpellLocal', { fg = c.vscRed, bg = c.vscBack, undercurl = true, sp = c.vscRed })
    hl(0, 'Whitespace', { fg = isDark and c.vscLineNumber or c.vscTabOther })

    -- Treesitter
    hl(0, 'TSUnderline', { fg = c.fg, bg = 'NONE', underline = true })
    --
    hl(0, '@error', { fg = c.vscRed, bg = 'NONE' })
    hl(0, '@punctuation.bracket', { fg = c.vscFront, bg = 'NONE' })
    hl(0, '@punctuation.special', { fg = c.blue, bg = 'NONE' })
    hl(0, '@comment', { fg = c.vscGreen, bg = 'NONE', italic = opts.italic_comments })
    hl(0, '@constant', { fg = c.green, bg = 'NONE' })
    hl(0, '@constant.builtin', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, '@constant.macro', { fg = c.orange, bg = 'NONE' })
    hl(0, '@string.regex', { fg = c.yellow, bg = 'NONE' })
    hl(0, '@string', { fg = c.yellow, bg = 'NONE' })
    hl(0, '@character', { fg = c.yellow, bg = 'NONE' })
    hl(0, '@number', { fg = c.vscLightGreen, bg = 'NONE' })
    hl(0, '@boolean', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, '@float', { fg = c.vscLightGreen, bg = 'NONE' })
    hl(0, '@annotation', { fg = c.yellow, bg = 'NONE' })
    hl(0, '@attribute', { fg = c.orange, bg = 'NONE' })
    hl(0, '@namespace', { fg = c.orange, bg = 'NONE' })
    hl(0, '@function.builtin', { fg = c.brown, bg = 'NONE' })
    hl(0, '@function', { fg = c.brown, bg = 'NONE' })
    hl(0, '@function.macro', { fg = c.brown, bg = 'NONE' })
    hl(0, '@parameter', { fg = c.green, bg = 'NONE' })
    hl(0, '@parameter.reference', { fg = c.green, bg = 'NONE' })
    hl(0, '@method', { fg = c.brown, bg = 'NONE' })
    hl(0, '@field', { fg = c.green, bg = 'NONE' })
    hl(0, '@property', { fg = c.green, bg = 'NONE' })
    hl(0, '@constructor', { fg = c.orange, bg = 'NONE' })
    hl(0, '@conditional', { fg = c.red, bg = 'NONE' })
    hl(0, '@conditional.ternary', { fg = c.vscFront, bg = 'NONE' })
    hl(0, '@repeat', { fg = c.red, bg = 'NONE' })
    hl(0, '@label', { fg = c.green, bg = 'NONE' })
    hl(0, '@keyword', { fg = c.blue, bg = 'NONE' })
    hl(0, '@keyword.return', { fg = c.red, bg = 'NONE' })
    hl(0, '@keyword.function', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, '@keyword.operator', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, '@keyword.coroutine', { fg = c.red, bg = 'NONE' })
    hl(0, '@operator', { fg = c.vscFront, bg = 'NONE' })
    hl(0, '@exception', { fg = c.red, bg = 'NONE' })
    hl(0, '@type', { fg = c.orange, bg = 'NONE' })
    hl(0, '@type.builtin', { fg = c.orange, bg = 'NONE' })
    hl(0, '@type.qualifier', { fg = c.blue, bg = 'NONE' })
    hl(0, '@storageClass', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, '@structure', { fg = c.green, bg = 'NONE' })
    hl(0, '@include', { fg = c.red, bg = 'NONE' })
    hl(0, '@variable', { fg = c.green, bg = 'NONE' })
    hl(0, '@variable.builtin', { fg = c.blue, bg = 'NONE' })
    hl(0, '@text', { fg = c.vscFront, bg = 'NONE' })
    hl(0, '@text.underline', { fg = c.yellow_orange, bg = 'NONE' })
    hl(0, '@tag', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, '@tag.delimiter', { fg = c.gray, bg = 'NONE' })
    hl(0, '@tag.attribute', { fg = c.green, bg = 'NONE' })

    hl(0, '@text.title', { fg = isDark and c.vscBlue or c.yellow_orange, bold = true })
    hl(0, '@text.literal', { fg = c.vscFront, bg = 'NONE' })
    hl(0, '@text.literal.markdown', { fg = c.yellow, bg = 'NONE' })
    hl(0, '@text.literal.markdown_inline', { fg = c.yellow, bg = 'NONE' })
    hl(0, '@text.emphasis', { fg = c.vscFront, bg = 'NONE', italic = true })
    hl(0, '@text.strong', { fg = isDark and c.vscBlue or c.vscViolet, bold = true })
    hl(0, '@text.uri', { fg = c.vscFront, bg = 'NONE' })
    hl(0, '@textReference', { fg = isDark and c.yellow or c.yellow_orange })
    hl(0, '@punctuation.delimiter', { fg = c.vscFront, bg = 'NONE' })
    hl(0, '@stringEscape', { fg = isDark and c.yellow or c.yellow_orange, bold = true })

    hl(0, '@text.note', { fg = c.orange, bg = 'NONE', bold = true })
    hl(0, '@text.warning', { fg = c.yellow_orange, bg = 'NONE', bold = true })
    hl(0, '@text.danger', { fg = c.vscRed, bg = 'NONE', bold = true })

    -- LSP semantic tokens
    hl(0, '@class', { link = '@type' })
    hl(0, '@struct', { link = '@type' })
    hl(0, '@enum', { link = '@type' })
    hl(0, '@enumMember', { link = '@constant' })
    hl(0, '@event', { link = 'Identifier' })
    hl(0, '@interface', { link = 'Identifier' })
    hl(0, '@modifier', { link = 'Identifier' })
    hl(0, '@regexp', { fg = c.vscRed, bg = 'NONE' })
    hl(0, '@typeParameter', { link = '@type' })
    hl(0, '@decorator', { link = 'Identifier' })

    -- Markdown
    hl(0, 'markdownBold', { fg = isDark and c.vscBlue or c.yellow_orange, bold = true })
    hl(0, 'markdownCode', { fg = c.vscOrange, bg = 'NONE' })
    hl(0, 'markdownRule', { fg = isDark and c.vscBlue or c.yellow_orange, bold = true })
    hl(0, 'markdownCodeDelimiter', { fg = c.vscFront, bg = 'NONE' })
    hl(0, 'markdownHeadingDelimiter', { fg = isDark and c.vscBlue or c.yellow_orange, bg = 'NONE' })
    hl(0, 'markdownFootnote', { fg = isDark and c.vscOrange or c.yellow_orange, bg = 'NONE' })
    hl(0, 'markdownFootnoteDefinition', { fg = isDark and c.vscOrange or c.yellow_orange })
    hl(0, 'markdownUrl', { fg = c.vscFront, bg = 'NONE', underline = true })
    hl(0, 'markdownLinkText', { fg = isDark and c.vscOrange or c.yellow_orange })
    hl(0, 'markdownEscape', { fg = isDark and c.vscOrange or c.yellow_orange })

    -- JSON
    hl(0, 'jsonKeyword', { fg = c.green, bg = 'NONE' })
    hl(0, 'jsonEscape', { fg = c.yellow_orange, bg = 'NONE' })
    hl(0, 'jsonNull', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, 'jsonBoolean', { fg = c.vscBlue, bg = 'NONE' })

    -- HTML
    hl(0, 'htmlTag', { fg = c.gray, bg = 'NONE' })
    hl(0, 'htmlEndTag', { fg = c.gray, bg = 'NONE' })
    hl(0, 'htmlTagName', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, 'htmlSpecialTagName', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, 'htmlArg', { fg = c.green, bg = 'NONE' })

    -- PHP
    hl(0, 'phpStaticClasses', { fg = c.orange, bg = 'NONE' })
    hl(0, 'phpMethod', { fg = c.yellow, bg = 'NONE' })
    hl(0, 'phpClass', { fg = c.orange, bg = 'NONE' })
    hl(0, 'phpFunction', { fg = c.yellow, bg = 'NONE' })
    hl(0, 'phpInclude', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, 'phpUseClass', { fg = c.orange, bg = 'NONE' })
    hl(0, 'phpRegion', { fg = c.orange, bg = 'NONE' })
    hl(0, 'phpMethodsVar', { fg = c.green, bg = 'NONE' })

    -- CSS
    hl(0, 'cssBraces', { fg = c.vscFront, bg = 'NONE' })
    hl(0, 'cssInclude', { fg = c.red, bg = 'NONE' })
    hl(0, 'cssTagName', { fg = c.yellow_orange, bg = 'NONE' })
    hl(0, 'cssClassName', { fg = c.yellow_orange, bg = 'NONE' })
    hl(0, 'cssPseudoClass', { fg = c.yellow_orange, bg = 'NONE' })
    hl(0, 'cssPseudoClassId', { fg = c.yellow_orange, bg = 'NONE' })
    hl(0, 'cssPseudoClassLang', { fg = c.yellow_orange, bg = 'NONE' })
    hl(0, 'cssIdentifier', { fg = c.yellow_orange, bg = 'NONE' })
    hl(0, 'cssProp', { fg = c.green, bg = 'NONE' })
    hl(0, 'cssDefinition', { fg = c.green, bg = 'NONE' })
    hl(0, 'cssAttr', { fg = c.vscOrange, bg = 'NONE' })
    hl(0, 'cssAttrRegion', { fg = c.vscOrange, bg = 'NONE' })
    hl(0, 'cssColor', { fg = c.vscOrange, bg = 'NONE' })
    hl(0, 'cssFunction', { fg = c.vscOrange, bg = 'NONE' })
    hl(0, 'cssFunctionName', { fg = c.vscOrange, bg = 'NONE' })
    hl(0, 'cssVendor', { fg = c.vscOrange, bg = 'NONE' })
    hl(0, 'cssValueNumber', { fg = c.vscOrange, bg = 'NONE' })
    hl(0, 'cssValueLength', { fg = c.vscOrange, bg = 'NONE' })
    hl(0, 'cssUnitDecorators', { fg = c.vscOrange, bg = 'NONE' })
    hl(0, 'cssStyle', { fg = c.green, bg = 'NONE' })
    hl(0, 'cssImportant', { fg = c.vscBlue, bg = 'NONE' })

    -- JavaScript
    hl(0, 'jsVariableDef', { fg = c.green, bg = 'NONE' })
    hl(0, 'jsFuncArgs', { fg = c.green, bg = 'NONE' })
    hl(0, 'jsFuncBlock', { fg = c.green, bg = 'NONE' })
    hl(0, 'jsRegexpString', { fg = c.red, bg = 'NONE' })
    hl(0, 'jsThis', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, 'jsOperatorKeyword', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, 'jsDestructuringBlock', { fg = c.green, bg = 'NONE' })
    hl(0, 'jsObjectKey', { fg = c.green, bg = 'NONE' })
    hl(0, 'jsGlobalObjects', { fg = c.orange, bg = 'NONE' })
    hl(0, 'jsModuleKeyword', { fg = c.green, bg = 'NONE' })
    hl(0, 'jsClassDefinition', { fg = c.orange, bg = 'NONE' })
    hl(0, 'jsClassKeyword', { fg = c.orange, bg = 'NONE' })
    hl(0, 'jsExtendsKeyword', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, 'jsExportDefault', { fg = c.blue, bg = 'NONE' })
    hl(0, 'jsFuncCall', { fg = c.yellow, bg = 'NONE' })
    hl(0, 'jsObjectValue', { fg = c.green, bg = 'NONE' })
    hl(0, 'jsParen', { fg = c.green, bg = 'NONE' })
    hl(0, 'jsObjectProp', { fg = c.green, bg = 'NONE' })
    hl(0, 'jsIfElseBlock', { fg = c.green, bg = 'NONE' })
    hl(0, 'jsParenIfElse', { fg = c.green, bg = 'NONE' })
    hl(0, 'jsSpreadOperator', { fg = c.green, bg = 'NONE' })
    hl(0, 'jsSpreadExpression', { fg = c.green, bg = 'NONE' })

    -- Typescript
    hl(0, 'typescriptDestructureVariable', { fg = c.green, bg = 'NONE' })
    hl(0, 'typescriptIdentifierName', { fg = c.orange, bg = 'NONE' })
    --
    hl(0, 'typescriptLabel', { fg = c.green, bg = 'NONE' })
    hl(0, 'typescriptExceptions', { fg = c.green, bg = 'NONE' })
    hl(0, 'typescriptBraces', { fg = c.vscFront, bg = 'NONE' })
    hl(0, 'typescriptEndColons', { fg = c.green, bg = 'NONE' })
    hl(0, 'typescriptParens', { fg = c.vscFront, bg = 'NONE' })
    hl(0, 'typescriptDocTags', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, 'typescriptDocComment', { fg = c.orange, bg = 'NONE' })
    hl(0, 'typescriptLogicSymbols', { fg = c.green, bg = 'NONE' })
    hl(0, 'typescriptImport', { fg = c.blue, bg = 'NONE' })
    hl(0, 'typescriptBOM', { fg = c.green, bg = 'NONE' })
    hl(0, 'typescriptVariableDeclaration', { fg = c.green, bg = 'NONE' })
    hl(0, 'typescriptVariable', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, 'typescriptExport', { fg = c.blue, bg = 'NONE' })
    hl(0, 'typescriptAliasDeclaration', { fg = c.orange, bg = 'NONE' })
    hl(0, 'typescriptAliasKeyword', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, 'typescriptClassName', { fg = c.orange, bg = 'NONE' })
    hl(0, 'typescriptAccessibilityModifier', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, 'typescriptOperator', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, 'typescriptArrowFunc', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, 'typescriptMethodAccessor', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, 'typescriptMember', { fg = c.yellow, bg = 'NONE' })
    hl(0, 'typescriptTypeReference', { fg = c.orange, bg = 'NONE' })
    hl(0, 'typescriptTemplateSB', { fg = c.yellow_orange, bg = 'NONE' })
    hl(0, 'typescriptArrowFuncArg', { fg = c.green, bg = 'NONE' })
    hl(0, 'typescriptParamImpl', { fg = c.green, bg = 'NONE' })
    hl(0, 'typescriptFuncComma', { fg = c.green, bg = 'NONE' })
    hl(0, 'typescriptCastKeyword', { fg = c.green, bg = 'NONE' })
    hl(0, 'typescriptCall', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, 'typescriptCase', { fg = c.green, bg = 'NONE' })
    hl(0, 'typescriptReserved', { fg = c.blue, bg = 'NONE' })
    hl(0, 'typescriptDefault', { fg = c.green, bg = 'NONE' })
    hl(0, 'typescriptDecorator', { fg = c.yellow, bg = 'NONE' })
    hl(0, 'typescriptPredefinedType', { fg = c.orange, bg = 'NONE' })
    hl(0, 'typescriptClassHeritage', { fg = c.orange, bg = 'NONE' })
    hl(0, 'typescriptClassExtends', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, 'typescriptClassKeyword', { fg = c.orange, bg = 'NONE' })
    hl(0, 'typescriptBlock', { fg = c.green, bg = 'NONE' })
    hl(0, 'typescriptDOMDocProp', { fg = c.green, bg = 'NONE' })
    hl(0, 'typescriptTemplateSubstitution', { fg = c.green, bg = 'NONE' })
    hl(0, 'typescriptClassBlock', { fg = c.green, bg = 'NONE' })
    hl(0, 'typescriptFuncCallArg', { fg = c.green, bg = 'NONE' })
    hl(0, 'typescriptIndexExpr', { fg = c.green, bg = 'NONE' })
    hl(0, 'typescriptConditionalParen', { fg = c.green, bg = 'NONE' })
    hl(0, 'typescriptArray', { fg = c.yellow, bg = 'NONE' })
    hl(0, 'typescriptES6SetProp', { fg = c.green, bg = 'NONE' })
    hl(0, 'typescriptObjectLiteral', { fg = c.green, bg = 'NONE' })
    hl(0, 'typescriptTypeParameter', { fg = c.orange, bg = 'NONE' })
    hl(0, 'typescriptEnumKeyword', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, 'typescriptEnum', { fg = c.orange, bg = 'NONE' })
    hl(0, 'typescriptLoopParen', { fg = c.green, bg = 'NONE' })
    hl(0, 'typescriptParenExp', { fg = c.green, bg = 'NONE' })
    hl(0, 'typescriptModule', { fg = c.green, bg = 'NONE' })
    hl(0, 'typescriptAmbientDeclaration', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, 'typescriptFuncTypeArrow', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, 'typescriptInterfaceHeritage', { fg = c.orange, bg = 'NONE' })
    hl(0, 'typescriptInterfaceName', { fg = c.orange, bg = 'NONE' })
    hl(0, 'typescriptInterfaceKeyword', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, 'typescriptInterfaceExtends', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, 'typescriptGlobal', { fg = c.orange, bg = 'NONE' })
    hl(0, 'typescriptAsyncFuncKeyword', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, 'typescriptFuncKeyword', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, 'typescriptGlobalMethod', { fg = c.yellow, bg = 'NONE' })
    hl(0, 'typescriptPromiseMethod', { fg = c.yellow, bg = 'NONE' })

    -- XML
    hl(0, 'xmlTag', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, 'xmlTagName', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, 'xmlEndTag', { fg = c.vscBlue, bg = 'NONE' })

    -- Ruby
    hl(0, 'rubyClassNameTag', { fg = c.orange, bg = 'NONE' })
    hl(0, 'rubyClassName', { fg = c.orange, bg = 'NONE' })
    hl(0, 'rubyModuleName', { fg = c.orange, bg = 'NONE' })
    hl(0, 'rubyConstant', { fg = c.orange, bg = 'NONE' })

    -- Golang
    hl(0, 'goPackage', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, 'goImport', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, 'goVar', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, 'goConst', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, 'goStatement', { fg = c.blue, bg = 'NONE' })
    hl(0, 'goType', { fg = c.orange, bg = 'NONE' })
    hl(0, 'goSignedInts', { fg = c.orange, bg = 'NONE' })
    hl(0, 'goUnsignedInts', { fg = c.orange, bg = 'NONE' })
    hl(0, 'goFloats', { fg = c.orange, bg = 'NONE' })
    hl(0, 'goComplexes', { fg = c.orange, bg = 'NONE' })
    hl(0, 'goBuiltins', { fg = c.yellow, bg = 'NONE' })
    hl(0, 'goBoolean', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, 'goPredefinedIdentifiers', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, 'goTodo', { fg = c.vscGreen, bg = 'NONE' })
    hl(0, 'goDeclaration', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, 'goDeclType', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, 'goTypeDecl', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, 'goTypeName', { fg = c.orange, bg = 'NONE' })
    hl(0, 'goVarAssign', { fg = c.green, bg = 'NONE' })
    hl(0, 'goVarDefs', { fg = c.green, bg = 'NONE' })
    hl(0, 'goReceiver', { fg = c.vscFront, bg = 'NONE' })
    hl(0, 'goReceiverType', { fg = c.vscFront, bg = 'NONE' })
    hl(0, 'goFunctionCall', { fg = c.yellow, bg = 'NONE' })
    hl(0, 'goMethodCall', { fg = c.yellow, bg = 'NONE' })
    hl(0, 'goSingleDecl', { fg = c.green, bg = 'NONE' })

    -- Python
    hl(0, 'pythonStatement', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, 'pythonOperator', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, 'pythonException', { fg = c.blue, bg = 'NONE' })
    hl(0, 'pythonExClass', { fg = c.orange, bg = 'NONE' })
    hl(0, 'pythonBuiltinObj', { fg = c.green, bg = 'NONE' })
    hl(0, 'pythonBuiltinType', { fg = c.orange, bg = 'NONE' })
    hl(0, 'pythonBoolean', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, 'pythonNone', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, 'pythonTodo', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, 'pythonClassVar', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, 'pythonClassDef', { fg = c.orange, bg = 'NONE' })

    -- TeX
    hl(0, 'texStatement', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, 'texBeginEnd', { fg = c.yellow, bg = 'NONE' })
    hl(0, 'texBeginEndName', { fg = c.green, bg = 'NONE' })
    hl(0, 'texOption', { fg = c.green, bg = 'NONE' })
    hl(0, 'texBeginEndModifier', { fg = c.green, bg = 'NONE' })
    hl(0, 'texDocType', { fg = c.blue, bg = 'NONE' })
    hl(0, 'texDocTypeArgs', { fg = c.green, bg = 'NONE' })

    -- Git
    hl(0, 'gitcommitHeader', { fg = c.gray, bg = 'NONE' })
    hl(0, 'gitcommitOnBranch', { fg = c.gray, bg = 'NONE' })
    hl(0, 'gitcommitBranch', { fg = c.blue, bg = 'NONE' })
    hl(0, 'gitcommitComment', { fg = c.gray, bg = 'NONE' })
    hl(0, 'gitcommitSelectedType', { fg = c.vscGreen, bg = 'NONE' })
    hl(0, 'gitcommitSelectedFile', { fg = c.vscGreen, bg = 'NONE' })
    hl(0, 'gitcommitDiscardedType', { fg = c.vscRed, bg = 'NONE' })
    hl(0, 'gitcommitDiscardedFile', { fg = c.vscRed, bg = 'NONE' })
    hl(0, 'gitcommitOverflow', { fg = c.vscRed, bg = 'NONE' })
    hl(0, 'gitcommitSummary', { fg = c.blue, bg = 'NONE' })
    hl(0, 'gitcommitBlank', { fg = c.blue, bg = 'NONE' })

    -- Lua
    hl(0, 'luaFuncCall', { fg = c.yellow, bg = 'NONE' })
    hl(0, 'luaFuncArgName', { fg = c.green, bg = 'NONE' })
    hl(0, 'luaFuncKeyword', { fg = c.blue, bg = 'NONE' })
    hl(0, 'luaLocal', { fg = c.blue, bg = 'NONE' })
    hl(0, 'luaBuiltIn', { fg = c.vscBlue, bg = 'NONE' })

    -- SH
    hl(0, 'shDeref', { fg = c.green, bg = 'NONE' })
    hl(0, 'shVariable', { fg = c.green, bg = 'NONE' })

    -- SQL
    hl(0, 'sqlKeyword', { fg = c.blue, bg = 'NONE' })
    hl(0, 'sqlFunction', { fg = c.yellow_orange, bg = 'NONE' })
    hl(0, 'sqlOperator', { fg = c.blue, bg = 'NONE' })

    -- YAML
    hl(0, 'yamlKey', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, 'yamlConstant', { fg = c.vscBlue, bg = 'NONE' })

    -- Gitgutter
    hl(0, 'GitGutterAdd', { fg = c.vscGreen, bg = 'NONE' })
    hl(0, 'GitGutterChange', { fg = c.yellow, bg = 'NONE' })
    hl(0, 'GitGutterDelete', { fg = c.vscRed, bg = 'NONE' })

    -- Git Signs
    hl(0, 'GitSignsAdd', { fg = c.vscGreen, bg = 'NONE' })
    hl(0, 'GitSignsChange', { fg = c.yellow, bg = 'NONE' })
    hl(0, 'GitSignsDelete', { fg = c.vscRed, bg = 'NONE' })
    hl(0, 'GitSignsAddLn', { fg = c.vscBack, bg = c.vscGreen })
    hl(0, 'GitSignsChangeLn', { fg = c.vscBack, bg = c.yellow })
    hl(0, 'GitSignsDeleteLn', { fg = c.vscBack, bg = c.vscRed })

    -- NvimTree
    hl(0, 'NvimTreeLineNr', { fg = c.vscLineNumber, bg = 'NONE' })
    --
    hl(0, 'NvimTreeRootFolder', { fg = c.vscFront, bg = 'NONE', bold = true })
    hl(0, 'NvimTreeGitDirty', { fg = c.yellow, bg = 'NONE' })
    hl(0, 'NvimTreeGitNew', { fg = c.vscGreen, bg = 'NONE' })
    hl(0, 'NvimTreeImageFile', { fg = c.vscViolet, bg = 'NONE' })
    hl(0, 'NvimTreeEmptyFolderName', { fg = c.gray, bg = 'NONE' })
    hl(0, 'NvimTreeFolderName', { fg = c.vscFront, bg = 'NONE' })
    hl(0, 'NvimTreeSpecialFile', { fg = c.blue, bg = 'NONE', underline = true })
    hl(0, 'NvimTreeNormal', { fg = c.vscFront, bg = opts.disable_nvimtree_bg and c.vscBack or c.bg3 })
    hl(0, 'NvimTreeCursorLine', { fg = 'NONE', bg = c.vscSelection })
    hl(0, 'NvimTreeVertSplit', { fg = opts.disable_nvimtree_bg and c.vscSplitDark or c.vscBack, bg = c.bg3 })
    hl(0, 'NvimTreeEndOfBuffer', { fg = opts.disable_nvimtree_bg and c.vscCursorDarkDark or c.vscLeftDark })
    hl(0, 'NvimTreeOpenedFolderName', { fg = c.vscFront, bg = c.bg3 })
    hl(0, 'NvimTreeGitRenamed', { fg = c.vscGitRenamed, bg = 'NONE' })
    hl(0, 'NvimTreeGitIgnored', { fg = c.vscGitIgnored, bg = 'NONE' })
    hl(0, 'NvimTreeGitDeleted', { fg = c.vscGitDeleted, bg = 'NONE' })
    hl(0, 'NvimTreeGitStaged', { fg = c.vscGitStageModified, bg = 'NONE' })
    hl(0, 'NvimTreeGitMerge', { fg = c.vscGitUntracked, bg = 'NONE' })
    hl(0, 'NvimTreeGitDirty', { fg = c.vscGitModified, bg = 'NONE' })
    hl(0, 'NvimTreeGitNew', { fg = c.vscGitAdded, bg = 'NONE' })

    -- Bufferline
    hl(0, 'BufferLineIndicatorSelected', { fg = c.vscLeftDark, bg = 'NONE' })
    hl(0, 'BufferLineFill', { fg = 'NONE', bg = c.vscLeftDark })

    -- BarBar
    hl(0, 'BufferCurrent', { fg = c.vscFront, bg = c.vscTabCurrent })
    hl(0, 'BufferCurrentIndex', { fg = c.orange, bg = c.vscTabCurrent })
    hl(0, 'BufferCurrentMod', { fg = c.yellow_orange, bg = c.vscTabCurrent })
    hl(0, 'BufferCurrentSign', { fg = c.vscFront, bg = c.vscTabCurrent })
    hl(0, 'BufferCurrentTarget', { fg = c.vscRed, bg = c.vscTabCurrent })
    hl(0, 'BufferVisible', { fg = c.gray, bg = c.vscTabCurrent })
    hl(0, 'BufferVisibleIndex', { fg = c.gray, bg = c.vscTabCurrent })
    hl(0, 'BufferVisibleMod', { fg = c.yellow_orange, bg = c.vscTabCurrent })
    hl(0, 'BufferVisibleSign', { fg = c.gray, bg = c.vscTabCurrent })
    hl(0, 'BufferVisibleTarget', { fg = c.vscRed, bg = c.vscTabCurrent })
    hl(0, 'BufferInactive', { fg = c.gray, bg = c.vscTabOther })
    hl(0, 'BufferInactiveIndex', { fg = c.gray, bg = c.vscTabOther })
    hl(0, 'BufferInactiveMod', { fg = c.yellow_orange, bg = c.vscTabOther })
    hl(0, 'BufferInactiveSign', { fg = c.gray, bg = c.vscTabOther })
    hl(0, 'BufferInactiveTarget', { fg = c.vscRed, bg = c.vscTabOther })
    hl(0, 'BufferTabpages', { fg = c.vscFront, bg = c.vscTabOther })
    hl(0, 'BufferTabpagesFill', { fg = c.vscFront, bg = c.vscTabOther })

    -- IndentBlankLine
    hl(0, 'IndentBlanklineContextChar', { fg = c.vscContextCurrent, bg = 'NONE', nocombine = true })
    hl(0, 'IndentBlanklineContextStart', { sp = c.vscContextCurrent, bg = 'NONE', nocombine = true, underline = true })
    hl(0, 'IndentBlanklineChar', { fg = c.vscContext, bg = 'NONE', nocombine = true })
    hl(0, 'IndentBlanklineSpaceChar', { fg = c.vscContext, bg = 'NONE', nocombine = true })
    hl(0, 'IndentBlanklineSpaceCharBlankline', { fg = c.vscContext, bg = 'NONE', nocombine = true })

    -- LSP
    hl(0, 'DiagnosticError', { fg = c.vscRed, bg = 'NONE' })
    hl(0, 'DiagnosticUnnecessary', { fg = c.gray, bg = 'NONE' })
    hl(0, 'DiagnosticWarn', { fg = c.yellow, bg = 'NONE' })
    hl(0, 'DiagnosticInfo', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, 'DiagnosticHint', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, 'DiagnosticUnderlineError', { fg = 'NONE', bg = 'NONE', undercurl = true, sp = c.vscRed })
    hl(0, 'DiagnosticUnderlineWarn', { fg = 'NONE', bg = 'NONE', undercurl = true, sp = c.yellow })
    hl(0, 'DiagnosticUnderlineInfo', { fg = 'NONE', bg = 'NONE', undercurl = true, sp = c.vscBlue })
    hl(0, 'DiagnosticUnderlineHint', { fg = 'NONE', bg = 'NONE', undercurl = true, sp = c.vscBlue })
    hl(0, 'LspReferenceText', { fg = 'NONE', bg = isDark and c.vscPopupHighlightGray or c.vscPopupHighlightLightBlue })
    hl(0, 'LspReferenceRead', { fg = 'NONE', bg = isDark and c.vscPopupHighlightGray or c.vscPopupHighlightLightBlue })
    hl(0, 'LspReferenceWrite', { fg = 'NONE', bg = isDark and c.vscPopupHighlightGray or c.vscPopupHighlightLightBlue })

    -- Nvim compe
    hl(0, 'CmpItemKindVariable', { fg = c.blue, bg = 'NONE' })
    hl(0, 'CmpItemKindInterface', { fg = c.blue, bg = 'NONE' })
    hl(0, 'CmpItemKindText', { fg = c.blue, bg = 'NONE' })
    hl(0, 'CmpItemKindFunction', { fg = c.blue, bg = 'NONE' })
    hl(0, 'CmpItemKindMethod', { fg = c.blue, bg = 'NONE' })
    hl(0, 'CmpItemKindKeyword', { fg = c.vscFront, bg = 'NONE' })
    hl(0, 'CmpItemKindProperty', { fg = c.vscFront, bg = 'NONE' })
    hl(0, 'CmpItemKindUnit', { fg = c.vscFront, bg = 'NONE' })
    hl(0, 'CmpItemKindConstructor', { fg = c.orange, bg = 'NONE' })
    hl(0, 'CmpItemMenu', { fg = c.vscPopupFront, bg = 'NONE' })
    hl(0, 'CmpItemAbbr', { fg = c.vscFront, bg = 'NONE' })
    hl(0, 'CmpItemAbbrDeprecated', { fg = c.vscCursorDark, bg = c.vscPopupBack, strikethrough = true })
    hl(0, 'CmpItemAbbrMatch', { fg = c.green, bg = 'NONE', bold = true })
    hl(0, 'CmpItemAbbrMatchFuzzy', { fg = c.green, bg = 'NONE', bold = true })

    -- Dashboard
    hl(0, 'DashboardHeader', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, 'DashboardDesc', { fg = c.yellow_orange, bg = 'NONE' })
    hl(0, 'DashboardIcon', { fg = c.yellow_orange, bg = 'NONE' })
    hl(0, 'DashboardShortCut', { fg = c.blue, bg = 'NONE' })
    hl(0, 'DashboardKey', { fg = c.vscWhite, bg = 'NONE' })
    hl(0, 'DashboardFooter', { fg = c.vscBlue, bg = 'NONE', italic = true })

    hl(0, 'NvimTreeFolderIcon', { fg = c.vscBlue, bg = 'NONE' })
    hl(0, 'NvimTreeIndentMarker', { fg = c.vscLineNumber, bg = 'NONE' })

    hl(0, 'LspFloatWinNormal', { fg = c.vscFront, bg = 'NONE' })
    hl(0, 'LspFloatWinBorder', { fg = c.vscLineNumber, bg = 'NONE' })
    hl(0, 'LspSagaHoverBorder', { fg = c.vscLineNumber, bg = 'NONE' })
    hl(0, 'LspSagaSignatureHelpBorder', { fg = c.vscLineNumber, bg = 'NONE' })
    hl(0, 'LspSagaCodeActionBorder', { fg = c.vscLineNumber, bg = 'NONE' })
    hl(0, 'LspSagaDefPreviewBorder', { fg = c.vscLineNumber, bg = 'NONE' })
    hl(0, 'LspLinesDiagBorder', { fg = c.vscLineNumber, bg = 'NONE' })
    hl(0, 'LspSagaRenameBorder', { fg = c.vscLineNumber, bg = 'NONE' })
    hl(0, 'LspSagaBorderTitle', { fg = c.vscCursorDark, bg = 'NONE' })
    hl(0, 'LSPSagaDiagnosticTruncateLine', { fg = c.vscLineNumber, bg = 'NONE' })
    hl(0, 'LspSagaDiagnosticBorder', { fg = c.vscLineNumber, bg = 'NONE' })
    hl(0, 'LspSagaDiagnosticBorder', { fg = c.vscLineNumber, bg = 'NONE' })
    hl(0, 'LspSagaShTruncateLine', { fg = c.vscLineNumber, bg = 'NONE' })
    hl(0, 'LspSagaShTruncateLine', { fg = c.vscLineNumber, bg = 'NONE' })
    hl(0, 'LspSagaDocTruncateLine', { fg = c.vscLineNumber, bg = 'NONE' })
    hl(0, 'LspSagaRenameBorder', { fg = c.vscLineNumber, bg = 'NONE' })
    hl(0, 'LspSagaLspFinderBorder', { fg = c.vscLineNumber, bg = 'NONE' })

    hl(0, 'TelescopeNormal', { fg = c.vscFront, bg = c.bg3 })
    hl(0, 'TelescopeBorder', { fg = c.vscFront, bg = c.bg3 })
    hl(0, 'TelescopeTitle', { fg = c.vscBack, bg = c.green })
    hl(0, 'TelescopePreviewNormal', { fg = c.vscFront, bg = c.bg4 })
    hl(0, 'TelescopePreviewBorder', { fg = c.vscLineNumber, bg = c.bg4 })
    hl(0, 'TelescopePromptBorder', { fg = c.vscLineNumber, bg = c.bg3 })
    hl(0, 'TelescopeResultsBorder', { fg = c.vscLineNumber, bg = c.bg3 })
    hl(0, 'TelescopeSelection', { fg = c.vscFront, bg = c.vscSelection })
    hl(0, 'TelescopeMultiSelection', { fg = c.vscFront, bg = c.vscSelection })
    hl(0, 'TelescopeMatching', { fg = c.vscMediumBlue, bg = 'NONE', bold = true })
    hl(0, 'TelescopePromptPrefix', { fg = c.vscFront, bg = 'NONE' })

    -- symbols-outline
    -- white fg and lualine blue bg
    hl(0, 'FocusedSymbol', { fg = '#ffffff', bg = c.vscUiBlue })
    hl(0, 'SymbolsOutlineConnector', { fg = c.vscLineNumber, bg = 'NONE' })

    -- plugins
    hl(0, 'HopNextKey', { fg = c.bright_red, bold = true })
    hl(0, 'HopNextKey1', { fg = c.bright_green, bold = true })
    hl(0, 'HopNextKey2', { fg = c.bright_green, bold = true })

    -- Scrollbar
    hl(0, 'ScrollbarHandle', { fg = 'NONE', bg = c.vscLeftLight })
end

theme.link_highlight = function()
    -- Legacy groups for official git.vim and diff.vim syntax
    hl(0, 'diffAdded', { link = 'DiffAdd' })
    hl(0, 'diffChanged', { link = 'DiffChange' })
    hl(0, 'diffRemoved', { link = 'DiffDelete' })
    -- Nvim compe
    hl(0, 'CompeDocumentation', { link = 'Pmenu' })
    hl(0, 'CompeDocumentationBorder', { link = 'Pmenu' })
    hl(0, 'CmpItemKind', { link = 'Pmenu' })
    hl(0, 'CmpItemKindClass', { link = 'CmpItemKindConstructor' })
    hl(0, 'CmpItemKindModule', { link = 'CmpItemKindKeyword' })
    hl(0, 'CmpItemKindOperator', { link = '@operator' })
    hl(0, 'CmpItemKindReference', { link = '@parameter.reference' })
    hl(0, 'CmpItemKindValue', { link = '@field' })
    hl(0, 'CmpItemKindField', { link = '@field' })
    hl(0, 'CmpItemKindEnum', { link = '@field' })
    hl(0, 'CmpItemKindSnippet', { link = '@text' })
    hl(0, 'CmpItemKindColor', { link = 'cssColor' })
    hl(0, 'CmpItemKindFile', { link = '@text.uri' })
    hl(0, 'CmpItemKindFolder', { link = '@text.uri' })
    hl(0, 'CmpItemKindEvent', { link = '@constant' })
    hl(0, 'CmpItemKindEnumMember', { link = '@field' })
    hl(0, 'CmpItemKindConstant', { link = '@constant' })
    hl(0, 'CmpItemKindStruct', { link = '@structure' })
    hl(0, 'CmpItemKindTypeParameter', { link = '@parameter' })
end

return theme
