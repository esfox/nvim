local colors = {}
colors.get_colors = function()
    local mycolors = {} ---@type table<string,string>

    mycolors = {
        vscNone = 'NONE',
        vscFront = '#d0d0d0',
        vscBack = '#353535',
        bg2 = '#333333',
        bg3 = '#303030',
        bg4 = '#393939',
        --
        vscTabCurrent = '#353535',
        vscTabOther = '#505050',
        vscTabOutside = '#353535',
        --
        vscLeftDark = '#252526',
        vscLeftMid = '#373737',
        vscLeftLight = '#636369',
        --
        vscPopupFront = '#BBBBBB',
        vscPopupBack = '#272727',
        vscPopupHighlightBlue = '#004b72',
        vscPopupHighlightGray = '#343B41',
        --
        vscSplitLight = '#898989',
        vscSplitDark = '#444444',
        vscSplitThumb = '#424242',
        --
        vscCursorDarkDark = '#222222',
        vscCursorDark = '#51504F',
        vscCursorLight = '#AEAFAD',
        vscSelection = '#376336',
        vscLineNumber = '#7a7a7a',
        -- vscSelection = '#264F78',
        -- vscLineNumber = '#5A5A5A',
        --
        vscDiffRedDark = '#4B1818',
        vscDiffRedLight = '#6F1313',
        vscDiffRedLightLight = '#FB0101',
        vscDiffGreenDark = '#373D29',
        vscDiffGreenLight = '#4B5632',
        vscSearchCurrent = '#515c6a',
        vscSearch = '#613315',
        --
        vscGitAdded = '#81b88b',
        vscGitModified = '#e2c08d',
        vscGitDeleted = '#c74e39',
        vscGitRenamed = '#73c991',
        vscGitUntracked = '#73c991',
        vscGitIgnored = '#8c8c8c',
        vscGitStageModified = '#e2c08d',
        vscGitStageDeleted = '#c74e39',
        vscGitConflicting = '#e4676b',
        vscGitSubmodule = '#8db9e2',
        --
        vscContext = '#404040',
        vscContextCurrent = '#707070',
        --
        vscFoldBackground = '#202d39',
        -- Syntax colors
        gray = '#969696',
        green = '#81c784',
        yellow_green = '#BDE578',
        blue = '#569CD6',
        light_blue = '#87e4f1',
        yellow = '#ded133',
        brown = '#bc8470',
        orange = '#ffb74d',
        red = '#e57373',
        purple = '#d9a9d8',
        yellow_orange = '#D7BA7D',
        bright_green = '#7ede83',
        bright_red = '#ff6666',
        vscViolet = '#646695',
        vscBlue = '#569CD6',
        vscDarkBlue = '#223E55',
        vscMediumBlue = '#18a2fe',
        vscGreen = '#779868',
        vscLightGreen = '#B5CEA8',
        vscRed = '#F44747',
        vscYellow = '#DCDCAA',
        vscOrange = '#CE9178',
        -- vscGray = '#808080',
        -- vscViolet = '#646695',
        -- vscBlue = '#569CD6',
        -- vscDarkBlue = '#223E55',
        -- vscMediumBlue = '#18a2fe',
        -- vscLightBlue = '#9CDCFE',
        -- vscGreen = '#6A9955',
        -- vscBlueGreen = '#4EC9B0',
        -- vscLightGreen = '#B5CEA8',
        -- vscRed = '#F44747',
        -- vscOrange = '#CE9178',
        -- vscLightRed = '#D16969',
        -- vscYellowOrange = '#D7BA7D',
        -- vscYellow = '#DCDCAA',
        -- vscPink = '#C586C0',
        --
        vscUiBlue = '#084671',
        vscUiOrange = '#f28b25',
        vscPopupHighlightLightBlue = '#d7eafe',

        warning = '#e5da5c',
    }

    return mycolors
end

return colors
