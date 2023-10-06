<h1 align="center">BAEGI</h1>

<!-- vscode-markdown-toc -->
* 1. [Info](#Info)
* 2. [AwesomeWM](#AwesomeWM)
* 3. [Hyperland](#Hyperland)
* 4. [4 Utilidades](#Utilidades)
	* 4.1. [Utilidades incluidas](#Utilidadesincluidas)
		* 4.1.1. [Hacking / Nework](#HackingNework)
* 5. [Setup](#Setup)
* 6. [Firefox](#Firefox)
* 7. [7. Vscode](#Vscode)

<!-- vscode-markdown-toc-config
	numbering=true
	autoSave=true
	/vscode-markdown-toc-config -->
<!-- /vscode-markdown-toc -->




##  1. <a name='Info'></a>Info

- OS: [Arch Linux](https://archlinux.org/)
- WM: [awesome](https://github.com/awesomeWM/awesome) with gnome utils
- Terminal: [wezterm](https://github.com/wez/wezterm)
- Shell: [zsh](https://www.zsh.org/) / [oh-my-zsh](https://ohmyz.sh)
- Editor: [neovim](https://github.com/neovim/neovim) / [vscode](https://github.com/microsoft/vscode)
- Compositor: [picom](https://github.com/yshui/picom)
- bar: [polybar](https://github.com/polybar/polybar)
- menu: [rofi theme](https://github.com/lr-tech/rofi-themes-collection.git)
- lock: [i3lock color](https://github.com/Raymo111/i3lock-color.git) [i3lock-fancy](https://github.com/meskarune/i3lock-fancy.git)

`Alt + H' Shortcuts

##  2. <a name='AwesomeWM'></a>AwesomeWM

<details>
<summary>Awesome</summary>

<div align='center'><img src='./.assets/20230311175646.png'/></div>
<div align='center'><img src='./.assets/20230311175706.png'/></div>

</details>

##  3. <a name='Hyperland'></a>Hyperland

<details>
<summary>Hyperland</summary>

Install from [prasanthrangan/hyprdots](https://github.com/prasanthrangan/hyprdots)

<div align='center'><img src='./.assets/20230917033941.png'/></div>
<div align='center'><img src='./.assets/20230917034017.png'/></div>
<div align='center'><img src='./.assets/20230917034102.png'/></div>

</details>

##  4. <a name='Utilidades'></a> Utilidades
###  4.1. <a name='Utilidadesincluidas'></a>Utilidades incluidas

- Nvim: [nv chad](https://github.com/NvChad/NvChad)
- [fzf](https://github.com/junegunn/fzf.git)
- [chatgpt](https://github.com/lencx/ChatGPT)

####  4.1.1. <a name='HackingNework'></a>Hacking / Nework

- [dnspython](https://github.com/rthalley/dnspython)
- [ubridge](https://github.com/GNS3/ubridge)
- [osintui](https://github.com/wssheldon/osintui)
- [Greal](https://github.com/AdonsIzaguirre/GReal)

##  5. <a name='Setup'></a>Setup

```sh
git clone https://github.com/b4391co/baegi
cd baegi
sh launch.sh
```


##  6. <a name='Firefox'></a>Firefox

- [wappalyzer](https://addons.mozilla.org/es/firefox/addon/wappalyzer/)
- [cookie-editor](https://addons.mozilla.org/en-US/firefox/addon/cookie-editor/)

##  7. <a name='Vscode'></a> Vscode

<details>
<summary>Vs code Config</summary>

<h3>Keybindings</h3>

```
// Place your key bindings in this file to override the defaultsauto[]
[
    {
        "key": "ctrl+e",
        "command": "-workbench.action.quickOpen"
    },
    {
        "key": "ctrl+alt+e",
        "command": "-rsync.edit"
    },
    {
        "key": "ctrl+alt+m",
        "command": "markdown-editor.openEditor",
        "when": "editorTextFocus && editorLangId == 'markdown'"
    },
    {
        "key": "ctrl+shift+alt+m",
        "command": "-markdown-editor.openEditor",
        "when": "editorTextFocus && editorLangId == 'markdown'"
    },
    {
        "key": "ctrl+b",
        "command": "-workbench.action.toggleSidebarVisibility"
    },
    {
        "key": "ctrl+shift+v",
        "command": "-notebook.cell.pasteAbove",
        "when": "notebookEditorFocused && !inputFocus"
    },
    {
        "key": "ctrl+shift+v",
        "command": "-html.showPreview",
        "when": "editorLangId == 'html'"
    },
    {
        "key": "ctrl+shift+v",
        "command": "-markdown.showPreview",
        "when": "!notebookEditorFocused && editorLangId == 'markdown'"
    },
    {
        "key": "ctrl+shift+v",
        "command": "-markdown.extension.closePreview",
        "when": "markdownPreviewFocus"
    },
    {
        "key": "tab",
        "command": "-markdown.extension.onTabKey",
        "when": "editorTextFocus && markdown.extension.editor.cursor.inList && !editorHasMultipleSelections && !editorReadonly && !editorTabMovesFocus && !hasOtherSuggestions && !hasSnippetCompletions && !inSnippetMode && !inlineSuggestionVisible && !markdown.extension.editor.cursor.inFencedCodeBlock && !markdown.extension.editor.cursor.inMathEnv && !suggestWidgetVisible && editorLangId =~ /^markdown$|^rmd$|^qmd$/"
    },
    {
        "key": "ctrl+u",
        "command": "md-shortcut.toggleCodeBlock",
        "when": "editorTextFocus && markdownShortcuts:enabled"
    },
    {
        "key": "ctrl+m ctrl+c",
        "command": "-md-shortcut.toggleCodeBlock",
        "when": "editorTextFocus && markdownShortcuts:enabled"
    },
    {
        "key": "ctrl+g",
        "command": "-workbench.action.gotoLine"
    },
    {
        "key": "ctrl+shift+b",
        "command": "telesoho.MarkdownPaste",
        "when": "editorTextFocus && resourceLangId == 'markdown'"
    },
    {
        "key": "ctrl+alt+v",
        "command": "-telesoho.MarkdownPaste",
        "when": "editorTextFocus && resourceLangId == 'markdown'"
    },
    {
        "key": "ctrl+shift+v",
        "command": "-markdown-preview-enhanced.openPreview",
        "when": "editorLangId == 'markdown'"
    },
    {
        "key": "shift+alt+v",
        "command": "-markdown-image.paste",
        "when": "editorLangId == 'markdown' || editorLangId == 'mdx' || resourceExtname == '.ipynb'"
    },
    {
        "key": "ctrl+shift+v",
        "command": "extension.pasteImage",
        "when": "editorTextFocus"
    },
    {
        "key": "ctrl+alt+v",
        "command": "-extension.pasteImage",
        "when": "editorTextFocus"
    },
    {
        "key": "ctrl+shift+b",
        "command": "-workbench.action.tasks.build",
        "when": "taskCommandsRegistered"
    },
    {
        "key": "ctrl+shift+b",
        "command": "workbench.action.maximizeEditor"
    },
    {
        "key": "ctrl+e",
        "command": "workbench.action.toggleSidebarVisibility"
    },
    {
        "key": "ctrl+shift+w",
        "command": "-workbench.action.closeWindow"
    },
    {
        "key": "ctrl+shift+e",
        "command": "-workbench.view.explorer",
        "when": "viewContainer.workbench.view.explorer.enabled"
    },
    {
        "key": "ctrl+shift+e",
        "command": "-workbench.action.quickOpenNavigatePreviousInFilePicker",
        "when": "inFilesPicker && inQuickOpen"
    },
    {
        "key": "ctrl+shift+l",
        "command": "glassit.decrease"
    },
    {
        "key": "ctrl+alt+c",
        "command": "-glassit.decrease"
    },
    {
        "key": "ctrl+alt+p",
        "command": "codesnap.start"
    },
    {
        "key": "ctrl+alt+x",
        "command": "-glassit.minimize"
    },
    {
        "key": "ctrl+j c",
        "command": "extension.javaGenerateConstructorUsingFields"
    },
    {
        "key": "ctrl+j g",
        "command": "extension.javaGenerateGettersAndSetter"
    },
    {
        "key": "ctrl+e",
        "command": "-workbench.action.quickOpenNavigateNextInFilePicker",
        "when": "inFilesPicker && inQuickOpen"
    },
    {
        "key": "ctrl+shift+s e",
        "command": "extension.executeSQLCommand",
        "when": "editorTextFocus && editorLangId == 'oraclesql'"
    },
    {
        "key": "ctrl+e",
        "command": "-extension.executeSQLCommand",
        "when": "editorTextFocus && editorLangId == 'oraclesql'"
    },
    {
        "key": "ctrl+shift+s e",
        "command": "oracleDBObjectExplorer.runCodeObjectFromFile",
        "when": "editorTextFocus && resourceScheme == 'oracle' && resource =~ /(objectType%3D13|objectType%3D15)/"
    },
    {
        "key": "ctrl+e",
        "command": "-oracleDBObjectExplorer.runCodeObjectFromFile",
        "when": "editorTextFocus && resourceScheme == 'oracle' && resource =~ /(objectType%3D13|objectType%3D15)/"
    },
    {
        "key": "ctrl+e",
        "command": "-editor.action.toggleScreenReaderAccessibilityMode",
        "when": "accessibilityHelpIsShown"
    },
    {
        "key": "ctrl+shift+e",
        "command": "workbench.action.terminal.toggleTerminal",
        "when": "terminal.active"
    },
    {
        "key": "ctrl+`",
        "command": "-workbench.action.terminal.toggleTerminal",
        "when": "terminal.active"
    },
    {
        "key": "ctrl+j r",
        "command": "java.run",
        "when": "editorTextFocus"
    },
    {
        "key": "alt+b",
        "command": "-java.run",
        "when": "editorTextFocus"
    },
    {
        "key": "ctrl+alt+r",
        "command": "-java.view.package.revealFileInOS",
        "when": "focusedView == 'javaProjectExplorer' && java:serverMode == 'Standard'"
    },
    {
        "key": "ctrl+j ctrl+r",
        "command": "command-runner.run"
    },
    {
        "key": "ctrl+alt+f",
        "command": "-command-runner.run"
    },
    {
        "key": "alt+e",
        "command": "workbench.action.files.openFolder",
        "when": "openFolderWorkspaceSupport"
    },
    {
        "key": "ctrl+k ctrl+o",
        "command": "-workbench.action.files.openFolder",
        "when": "openFolderWorkspaceSupport"
    }
    {
        "key": "ctrl+j ctrl+s",
        "command": "type",
        "args": {
            "text": "Scanner scan = new Scanner(System.in);"
        },
        "when": "editorTextFocus && !editorReadonly"
    }
    {
        "key": "ctrl+j ctrl+shift+s",
        "command": "type",
        "args": {
            "text": "import java.util.Scanner;"
        },
        "when": "editorTextFocus && !editorReadonly"
    }
]
```

<h3>settings</h3>

```
{
    "terminal.integrated.fontFamily": "'Victor Mono','hack nerd font mono', consolas, monospace, haks, console, montserrat, 'Droid Sans Mono', 'monospace', 'Droid Sans Fallback'",
	"terminal.integrated.gpuAcceleration": "on",
    "workbench.editorAssociations": {
        "*.ipynb": "jupyter-notebook"
    },
    "explorer.confirmDelete": false,
    "editor.renderWhitespace": "none",
    "vsicons.dontShowNewVersionMessage": true,
    "oracledevtools.bookmarkFileFolder": "/home/ASIR/blodeiro/Oracle/oracle.oracledevtools",
    "oracledevtools.connectionConfiguration.configFilesFolder": "/home/ASIR/blodeiro/Oracle/network/admin",
    "oracledevtools.connectionConfiguration.walletFileFolder": "/home/ASIR/blodeiro/Oracle/network/admin",
    "oracledevtools.connections": [],
    "mssql.connections": [
        {
            "server": "{{put-server-name-here}}",
            "database": "{{put-database-name-here}}",
            "user": "{{put-username-here}}",
            "password": ""
        }
    ],
    "glassit.alpha": 235,
    "vscodeGoogleTranslate.preferredLanguage": "Spanish",
    "explorer.confirmDragAndDrop": false,
    "notebook.cellToolbarLocation": {
        "default": "right",
        "jupyter-notebook": "left"
    },
    "workbench.editor.untitled.hint": "hidden",
    "kite.showWelcomeNotificationOnStartup": false,
    "tabnine.experimentalAutoImports": true,
    "workbench.colorTheme": "Palenight Operator",
    "editor.fontFamily": "'VictorMono Nerd Font','JetBrains Mono', monospace",
    "editor.tokenColorCustomizations": {    /* darrr */
        "textMateRules": [

            {
                "name": "all",
                "scope": [
                    "all",
                    "comment",
                    "entity.name.type.class",
                    "keyword",
                    "storage.modifier",
                    "storage.type",
                    "support.class.builtin",
                    "keyword.control",
                    "constant.language",
                    "entity.other.attribute-name",
                    "entity.name.method",
                    "entity.name.tag",
                    "string.quoted",
                ],
                "settings": {
                    "fontStyle": "italic"
                }
            },
            {
                "name": "constant.numeric",
                "scope": [
                    "constant"
                ],
                "settings": {
                    "foreground": "#15ff00",
                    "fontStyle": "bold"
                }
            },
            {
                "name": "comment", 
                "scope": [
                    "comment",
                    "punctuation.definition.comment"
                ],
                "settings": {
                    "fontStyle": "italic"
                }
            },
            {
                "name": "envKeys",
                "scope": "string.quoted.double.env,source.env,constant.numeric.env",
                "settings": {
                    "foreground": "#19354900",
                }
            }
        ]
    },
    "editor.fontLigatures": true,
    "editor.letterSpacing": 0,
    "editor.tabSize": 4,
    "database-client.recordSelectSQL": false,
    "database-client.showTrigger": true,
    "editor.minimap.maxColumn": 100,
    "editor.minimap.renderCharacters": false,
    "terminal.integrated.defaultProfile.linux": "zsh",
    "editor.cursorSmoothCaretAnimation": "on",
    "editor.smoothScrolling": true,
    "editor.cursorBlinking": "expand",
    "editor.cursorStyle": "line",
    "editor.renderWhitespace": "selection",
    "breadcrumbs.enabled": true,
    "git.enableSmartCommit": true,
	"git.confirmSync": false,
    "google.drive.alertMissingCredentials": false,
    "markdown-pdf.headerTemplate": "<div style=\"font-size: 9px; margin-left: 1cm;\"> <span>Nombre Apellido</span></div> <div style=\"font-size: 9px; margin-left: auto; margin-right: 1cm; \"> <span class='date'></span></div>",
    "[markdown]": {
        "editor.defaultFormatter": "yzhang.markdown-all-in-one"
    },
    "MarkdownPaste.path": "${fileDirname}/.assets",
    "outline-map.color": {
    
    },
    "outline-map.defaultMaxDepth": 3,
    "outline-map.maxDepth": 5,
    "cSpell.language": "es-ES,es",
    "markdown-preview-enhanced.imageFolderPath": "/.assets",
    "MarkdownPaste.lang_rules": [

        {
            "asciidoc": [
                {
                    "regex": "^(?:https?://)?(?:(?:(?:www\\.?)?youtube\\.com(?:/(?:(?:watch\\?.*?v=([^&\\s]+).*)|))?))",
                    "options": "g",
                    "replace": "image::https://img.youtube.com/vi/$1/0.jpg[link=\"https://www.youtube.com/watch?v=$1\"]"
                },
                {
                    "regex": "^(https?://.*)",
                    "options": "ig",
                    "replace": "image::$1[linktext,300]"
                },
                {
                    "regex": "(.*/media/)(.*)",
                    "options": "",
                    "replace": "image::$2[linktext,300]"
                }
            ]
        }
    ],
    "MarkdownPaste.rules": [

        {
            "regex": "^(?:https?://)?(?:(?:(?:www\\.?)?youtube\\.com(?:/(?:(?:watch\\?.*?v=([^&\\s]+).*)|))?))",
            "options": "g",
            "replace": "[![](https://img.youtube.com/vi/$1/0.jpg)](https://www.youtube.com/watch?v=$1)"
        },
        {
            "regex": "^(https?://.*)",
            "options": "ig",
            "replace": "[]($1)"
        }
    ],
    "MarkdownPaste.silence": true,
    "ShortcutMenuBar.paste": true,
    "pastePicture.markdownFormat": "html",
    "pasteImage.basePath": "${currentFileDir}/.assets",
    "pasteImage.path": "${currentFileDir}/.assets",
    "pasteImage.insertPattern": "<div align='center'><img src='./.assets/${imageFileName}'/></div>",
    "launch": {
    
        "configurations": [],
        "compounds": []
    },
    "pasteImage.defaultName": "YMMDDHHmmss",
    "json.schemas": [

    
    ],
    "workbench.iconTheme": "vscode-simpler-icons",
    "editor.fontVariations": false,
    "git.autofetch": true,
    "extensions.ignoreRecommendations": true,
    "cSpell.languageSettings": [
    

    
    ],
    "oracledevtools.download.otherFolder": "/home/b4391co/downloads",
    "files.autoSave": "afterDelay",
    "vscode-blur-linux.opacity": 80,
    "codesnap.backgroundColor": "#ffffff",
    "codesnap.shutterAction": "copy",
    "codesnap.target": "window",
    "codesnap.transparentBackground": true,
    "VSCodeNotion.accessToken": "secret_lnfV1ugNHqDpCpN2JgYkDJ2kp7qqn5lXlvoj3S5a991",
    "liveServer.settings.donotShowInfoMsg": true,
    "window.zoomLevel": 0.4,
    "projectManager.git.baseFolders": [
        "/home/b4391co/git"
    ],
    "java.project.resourceFilters": [
        "node_modules",
        "\\.git"
    ]
    

    
}
```


</details>