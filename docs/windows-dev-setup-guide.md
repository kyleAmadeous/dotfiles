# Windows ê°ë° íê²½ ì¤ì  ê°ì´ë

> ROG Zephyrus G14 (GA401IU) / Windows 11 ê¸°ì¤
> íì¤í + DevOps ê°ë°ìì© ì¢í© ì¤ì 

---

## 1. Windows ê¸°ë³¸ ì¤ì  ë° íì ì±

### 1-1. Windows ì¤ì 

```powershell
# ê°ë°ì ëª¨ë íì±í
# ì¤ì  â ìì¤í â ê³ ê¸ â ê°ë°ì ëª¨ë ì¼ê¸°

# íì¼ íìê¸° ì¤ì 
# - íì¼ íì¥ì íì: ë³´ê¸° â íì¼ íì¥ëª ì²´í¬
# - ì¨ê¹ íì¼ íì: ë³´ê¸° â ì¨ê¸´ í­ëª© ì²´í¬
```

### 1-2. íì ì± ì¤ì¹ (winget íì©)

```powershell
# wingetì Windows 11ì ê¸°ë³¸ ë´ì¥
winget install Microsoft.WindowsTerminal
winget install Microsoft.VisualStudioCode
winget install Google.Chrome
winget install Notepad++.Notepad++
winget install 7zip.7zip
winget install Microsoft.PowerToys
winget install Warp.Warp
winget install Dropbox.Dropbox

# AI & ìì°ì± ì±
winget install Anthropic.Claude
winget install OpenAI.ChatGPT
```

---

## 2. PowerToys ì¤ì¹ ë° ì¤ì 

### 2-1. ì¤ì¹

```powershell
winget install Microsoft.PowerToys
```

### 2-2. ì¶ì² íì±í ê¸°ë¥

| ê¸°ë¥ | ì©ë | ë¨ì¶í¤ |
|------|------|--------|
| **FancyZones** | ì°½ ë¶í  ë ì´ìì ê´ë¦¬ | `Win + Shift + '` |
| **PowerToys Run** | ë¹ ë¥¸ ì±/íì¼ ê²ì (Spotlight ëì²´) | `Alt + Space` |
| **Color Picker** | íë©´ ìì ì¶ì¶ | `Win + Shift + C` |
| **File Locksmith** | íì¼ ì ê¸ íë¡ì¸ì¤ íì¸ | ì°í´ë¦­ ë©ë´ |
| **Image Resizer** | ì´ë¯¸ì§ ì¼ê´ í¬ê¸° ì¡°ì  | ì°í´ë¦­ ë©ë´ |
| **Keyboard Manager** | í¤ ë¦¬ë§µí | ì¤ì ìì ì§ì  |
| **Paste as Plain Text** | ìì ìì´ ë¶ì¬ë£ê¸° | `Win + Ctrl + V` |
| **Always On Top** | ì°½ í­ì ìì ê³ ì  | `Win + Ctrl + T` |
| **Peek** | íì¼ ë¯¸ë¦¬ë³´ê¸° (Space) | `Ctrl + Space` |

### 2-3. ì¶ì² ì¤ì 

```
- FancyZones: 3ì´ ë ì´ìì ëë ì»¤ì¤í ë ì´ìì ì¤ì 
- PowerToys Run: íë¬ê·¸ì¸ìì Calculator, Unit Converter íì±í
- ìì ì ìë ì¤í: ì¤ì  â ì¼ë° â ê´ë¦¬ì ëª¨ëë¡ ìì ì²´í¬
```

---

## 3. Windows Terminal ì¤ì 

### 3-1. ì¤ì¹

```powershell
winget install Microsoft.WindowsTerminal
```

### 3-2. ì¶ì² settings.json ì¤ì 

```jsonc
// ì¤ì  â JSON íì¼ ì´ê¸° (Ctrl + Shift + ,)
{
    "defaultProfile": "{Ubuntu WSL GUID}",
    "theme": "dark",
    "defaults": {
        "font": {
            "face": "CaskaydiaCove Nerd Font",
            "size": 12
        },
        "opacity": 90,
        "useAcrylic": true,
        "padding": "8"
    }
}
```

### 3-3. Nerd Font ì¤ì¹ (ìì´ì½ ì§ì)

```powershell
# Oh My Zsh íë§ìì ìì´ì½ì ì ëë¡ íìíë ¤ë©´ Nerd Font íì
winget install --id=Nerdfont.CaskaydiaCove -e
# ëë https://www.nerdfonts.com ìì ì§ì  ë¤ì´ë¡ë
```

---

## 4. Warp í°ë¯¸ë ì¤ì 

> Warpë Rust ê¸°ë°ì AI ë´ì¥ ëª¨ë í°ë¯¸ëë¡, ìëìì±, ëªë ¹ì´ ë¸ë¡ ë¨ì ì¤í, AI ëªë ¹ì´ ì¶ì² ë±ì ì§ìí©ëë¤. Windows Terminalê³¼ ë³í ì¬ì©íê±°ë ëì²´ í°ë¯¸ëë¡ íì©í  ì ììµëë¤.

### 4-1. ì¤ì¹

```powershell
winget install Warp.Warp
```

### 4-2. ì£¼ì í¹ì§

| ê¸°ë¥ | ì¤ëª |
|------|------|
| **AI Command Search** | ìì°ì´ë¡ ëªë ¹ì´ë¥¼ ê²ìíê³  ìë ìì± (`Ctrl + \``) |
| **Blocks** | ëªë ¹ì´ì ì¶ë ¥ì ë¸ë¡ ë¨ìë¡ êµ¬ë¶íì¬ ê´ë¦¬ |
| **Workflows** | ìì£¼ ì°ë ëªë ¹ì´ ìíì¤ë¥¼ ì ì¥íê³  ì¬ì¬ì© |
| **Smart Autocomplete** | ì»¨íì¤í¸ ê¸°ë° ìëìì± |
| **Agent Mode** | AIê° í°ë¯¸ë ììì ëìì£¼ë ìì´ì í¸ ëª¨ë |
| **Warp Drive** | íìê³¼ ëªë ¹ì´/ìí¬íë¡ì° ê³µì  |

### 4-3. ì¶ì² ì¤ì 

```
ì¤ì  â Appearance
  - í°í¸: CaskaydiaCove Nerd Font (Nerd Font í¸í)
  - íë§: Dracula ëë Tokyo Night

ì¤ì  â Features
  - Default shell: WSL Ubuntuì zshë¡ ì¤ì 
  - AI: Warp AI íì±í

ì¤ì  â Keys
  - ë¨ì¶í¤ ì»¤ì¤í°ë§ì´ì§ ê°ë¥
```

### 4-4. WSL ì°ë

```
Warpìì WSLì ê¸°ë³¸ ìë¡ ì¬ì©íë ¤ë©´:
  1. ì¤ì  â Features â Session â Default shell
  2. "wsl.exe -d Ubuntu" ëë "wsl.exe --cd ~" ë¡ ì¤ì 
  3. Warp ì¬ìì
```

### 4-5. Windows Terminal vs Warp ë¹êµ

| í­ëª© | Windows Terminal | Warp |
|------|-----------------|------|
| **AI ê¸°ë¥** | ìì | ë´ì¥ (ëªë ¹ì´ ê²ì/ìì±) |
| **ìë** | ë¹ ë¦ | ë¹ ë¦ (Rust ê¸°ë°) |
| **ë¸ë¡ ê´ë¦¬** | ìì | ëªë ¹ì´ë³ ë¸ë¡ êµ¬ë¶ |
| **ì»¤ì¤í°ë§ì´ì§** | JSON ì¤ì  | GUI ì¤ì  |
| **WSL ì§ì** | ë¤ì´í°ë¸ | ì§ì
