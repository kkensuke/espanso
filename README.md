# My Espanso Configuration

Personal [Espanso](https://espanso.org/) configuration for macOS, with snippets for writing, coding, browser/app shortcuts, scientific notation, clipboard workflows, and LLM-assisted text processing.

> [!NOTE]
> This is a personal configuration rather than a plug-and-play Espanso package. Several matches assume macOS, specific applications, custom directory layouts, or private global variables. Review the files you want to use and adapt paths/apps to your environment.

## Highlights

- **LLM workflows with Google Gemini** — translate clipboard text, rephrase scientific writing, and build proofreading prompts.
- **Text and writing helpers** — Japanese greetings, character/word counts, case conversion, quoting, Markdown snippets, and reusable forms.
- **Browser and application shortcuts** — open Google, ChatGPT, Gemini, Claude, GitHub, Google Scholar, Ghostty, and other apps/sites.
- **Clipboard list** — append, display, delete, and clear saved clipboard entries in a private file under `ignore/`.
- **Scientific/coding snippets** — Python templates, math symbols, Greek letters, and quantum-state notation.
- **macOS automation** — Finder path copying, desktop icon toggling, `hidutil`, AppleScript, and other shell-based utilities.
- **Touch ID / Keychain example** — retrieve a secret through `kctouch` after Touch ID authentication.

## Requirements

### Core

- [Espanso](https://espanso.org/)
- macOS for many of the included shell/automation matches
- `jq`
- `curl`

With Homebrew:

```bash
brew install jq
```

Many snippets use macOS commands such as `open`, `osascript`, `pbcopy`, `pbpaste`, `defaults`, `hidutil`, and BSD `sed`.

### Optional tools and apps

Only install these if you use the corresponding snippets:

- `kctouch` for `match/touchID.yml`
- Ghostty for `;er`, `;tml`, and the VS Code/project-opening helpers
- VS Code and the `code` CLI for project-opening snippets
- Google Chrome for `;tab` and the `;example` script example
- `python3` for `;python`, `;hash`, and repository/text helpers
- `uv` for the `;uvinit` Python trigger
- Aerospace for the `;gap` utility
- GNU `shuf` for `;dice` (adapt the command or make `shuf` available on macOS)

Some snippets also rely on common Unix utilities that may differ between macOS and Linux. Check the shell command in the relevant match before using it on another platform.

## Installation

### 1. Install Espanso

Install Espanso using the [official installation guide](https://espanso.org/install/).

Find your active configuration paths with:

```bash
espanso path
```

This repository mirrors an Espanso configuration root with `config/`, `match/`, and supporting directories. Back up your existing configuration before replacing it, or copy only the files you want to use.

### 2. Set up private files

`match/base.yml` currently imports three files that intentionally live outside version control:

```yaml
imports:
  - "../ignore/global_vars.yml"
  - "../ignore/others.yml"
  - "../ignore/asdf.yml"
```

The repository `.gitignore` excludes the entire `ignore/` directory, so it is the intended place for machine-specific variables, private snippets, and local state.

Create the imported files you use, or remove unused imports from `match/base.yml`. Several matches reference personal globals such as:
- `ESPANSO` — path used by local state/config helpers
- `GITHUB` — local GitHub/projects directory
- `DOTFILES` — local dotfiles directory
- `GEMINI_API_KEY` — Google Gemini API key

Because some shell commands interpolate these variables directly, adapt the paths and quoting to your environment.

### 3. Configure Gemini (optional)

`match/llm.yml` uses the Gemini API through `curl` and parses responses with `jq`. The current model setting is:

```yaml
gemini-flash-lite-latest
```

If you want to use the LLM triggers, obtain an API key from [Google AI Studio](https://aistudio.google.com/app/apikey) and define `GEMINI_API_KEY` in an ignored file such as `ignore/global_vars.yml`:

```yaml
global_vars:
  - name: GEMINI_API_KEY
    type: echo
    params:
      echo: "YOUR_GEMINI_API_KEY"
```

Do not commit real API keys or other secrets.

### 4. Restart Espanso

After changing the configuration, restart Espanso:

```bash
espanso restart
```

## Configuration Files

| File | Purpose |
| --- | --- |
| `config/default.yml` | Global Espanso options such as icon visibility, clipboard threshold, undo behavior, and search trigger. |
| `config/backend_clipboard.yml` | Uses the clipboard injection backend for VS Code / Chrome matching classes. |
| `config/disable.yml` | Excludes `match/excluded.yml` from normal loading when that local file exists. |

## Match Guide

| File | Purpose |
| --- | --- |
| `match/base.yml` | Shared clipboard/date variables, private imports, `;date`, `;now`, the Ghostty restart helper, and the WORK/PERSONAL state toggle. |
| `match/shell.yml` | Echo/shell/script examples plus IP, dice, UUID, password, SHA-256, and random-excuse helpers. |
| `match/emoji.yml` | macOS keyboard symbols, emoji shortcuts, and an emoji picker form. |
| `match/chrome.yml` | Browser/site shortcuts including Google, ChatGPT, Gemini, Claude, GitHub, Scholar, YouTube, and Chrome helpers. |
| `match/form.yml` | Espanso form examples and a TODO form. |
| `match/llm.yml` | Gemini API integration for translation, rephrasing, and proofreading prompt helpers. |
| `match/english_guideline.yml` | Academic English checklist exposed as the `english_guideline` global variable. |
| `match/japanese_guideline.yml` | Japanese writing guideline exposed as the `japanese_guideline` global variable. |
| `match/math.yml` | Greek letters, mathematical symbols, set/calculus/logic notation, and simple regex calculations. |
| `match/physics.yml` | Quantum notation such as ket, bra, inner product, and expectation value. |
| `match/md.yml` | Markdown/code-block and documentation shortcuts. |
| `match/python.yml` | Python imports, environment commands, class/file/pickle templates, and plotting snippets. |
| `match/text.yml` | Greetings, text cleanup, counts, quoting, and case conversion. |
| `match/open.yml` | Open Ghostty, the Espanso configuration, a quantum-computing directory, or a selected local GitHub repository. |
| `match/file.yml` | Create a desktop memo or a Windows-compatible `.url` shortcut from the clipboard. |
| `match/save_clipboard.yml` | Persistent clipboard list stored in `ignore/clipboard_list.md`. |
| `match/touchID.yml` | Example `kctouch` integration for retrieving a Keychain secret after Touch ID authentication. |
| `match/utils.yml` | macOS/Finder/system helpers, URL shortening, dictionary lookup, currency conversion, and personal workflow utilities. |

## Featured Triggers

| Trigger | Action |
| --- | --- |
| `;date` | Insert the current date as `YYYY/MM/DD`. |
| `;now` | Insert the current timestamp. |
| `;er` | Open Ghostty and prepare an `espanso restart` command. |
| `;state;focus` | Toggle `state/state_focus.txt` between `WORK` and `PERSONAL`. |
| `;tml` | Open Ghostty. |
| `;gpt` | Open ChatGPT. |
| `;ggl` | Search Google for the current clipboard text. |
| `;scholar` | Search Google Scholar for the current clipboard text. |
| `;jet` | Translate clipboard content to English through Gemini. |
| `;ejt` | Translate clipboard content to Japanese through Gemini. |
| `;rephrase` | Ask Gemini for three scientific-writing rephrasings of clipboard text. |
| `;case` | Convert clipboard text to upper/lower/Pascal/camel/title/kebab/snake case. |
| `;chars` / `;words` | Count clipboard characters or words. |
| `;cdgh` | Choose a directory under `{{GITHUB}}` and prepare to open it in VS Code. |
| `;memo` | Create `~/Desktop/temp/memo.md` and prepare to open it in VS Code. |
| `;urlNAME;` | Create `~/Desktop/NAME.url` from the clipboard URL. |
| `;hash` | Insert the SHA-256 digest of the clipboard text using Python. |
| `;additem` | Append clipboard text to the private clipboard list. |
| `;showlist` | Show all saved clipboard entries. |
| `;delitem` | Select and remove one clipboard entry. |
| `;allemoji` | Open the emoji picker form. |
| `;touchid` | Retrieve the configured Keychain secret with `kctouch`. |
| `;ket` / `;bra` | Insert basic quantum-state notation. |

## Clipboard List

`match/save_clipboard.yml` stores clipboard entries in:

```text
{{ESPANSO}}/ignore/clipboard_list.md
```

Available triggers:

| Trigger | Action |
| --- | --- |
| `;additem` | Append sanitized clipboard text with a timestamp. |
| `;showlist` | Display the saved list. |
| `;delitem` | Pick a numbered entry and delete it. |
| `;dellist` | Clear the list. |

The `ignore/` directory is excluded by `.gitignore`, which helps keep clipboard contents and other local/private files out of the repository.


## JSON → YAML Example Generator

`scripts/json_to_yml.sh` is a helper script that converts a JSON file into an Espanso YAML configuration with global variables and triggers.

It currently:
1. Reads `ignore/global_vars.json`.
2. Generates Espanso `global_vars` and matching `;VARIABLE_NAME` triggers.
3. Writes the result to `ignore/global_vars.yml`.

Run it with `ESPANSO` set to the configuration root:

```bash
export ESPANSO="/path/to/espanso/config-root"
./scripts/json_to_yml.sh
```

### Example JSON and Generated YAML

```json
{
  "api_keys": {
    "YOUR_GEMINI_API_KEY": "your_gemini_api_key_here"
  },
  "urls": {
    "blog_url": "https://yourblog.com",
    "portfolio": "https://yourportfolio.com"
  },
  "paths": {
    "projects": "~/path/to/projects",
    "backup": "~/path/to/backups"
  },
  "personal": {
    "your_name": "Your Name",
    "your_mail": "your.email@example.com",
    "your_phone": "+1-234-567-8900"
  }
}
```

```yaml
# ========================================
# Auto-generated from global_vars.json
# Generated on: Sun Feb 22 15:21:37 JST 2026
# ========================================

global_vars:
  # --- API_KEYS ---
  - name: "YOUR_GEMINI_API_KEY"
    type: echo
    params:
      echo: "your_gemini_api_key_here"

  # --- URLS ---
  - name: "blog_url"
    type: echo
    params:
      echo: "https://yourblog.com"
  - name: "portfolio"
    type: echo
    params:
      echo: "https://yourportfolio.com"

  # --- PATHS ---
  - name: "projects"
    type: echo
    params:
      echo: "~/path/to/projects"
  - name: "backup"
    type: echo
    params:
      echo: "~/path/to/backups"

  # --- PERSONAL ---
  - name: "your_name"
    type: echo
    params:
      echo: "Your Name"
  - name: "your_mail"
    type: echo
    params:
      echo: "your.email@example.com"
  - name: "your_phone"
    type: echo
    params:
      echo: "+1-234-567-8900"


matches:
# --- API_KEYS ---
  - trigger: ";YOUR_GEMINI_API_KEY"
    replace: "{{YOUR_GEMINI_API_KEY}}"

# --- URLS ---
  - trigger: ";blog_url"
    replace: "{{blog_url}}"
  - trigger: ";portfolio"
    replace: "{{portfolio}}"

# --- PATHS ---
  - trigger: ";projects"
    replace: "{{projects}}"
  - trigger: ";backup"
    replace: "{{backup}}"

# --- PERSONAL ---
  - trigger: ";your_name"
    replace: "{{your_name}}"
  - trigger: ";your_mail"
    replace: "{{your_mail}}"
  - trigger: ";your_phone"
    replace: "{{your_phone}}"
```


## Touch ID / Keychain

`match/touchID.yml` demonstrates retrieving a secret from the macOS Keychain with [`kctouch`](https://github.com/rgeraskin/kctouch).

After installing `kctouch`, create a Keychain entry using service/account names of your choice, then update the placeholders in `match/touchID.yml`:

```bash
kctouch add --service "YOUR_SERVICE_NAME" --account "YOUR_ACCOUNT_NAME"
```

The `;touchid` trigger uses the corresponding `kctouch get` command and requires Touch ID authentication.

## Expected Local Repository Structure

```text
.
├── .gitignore
├── README.md
├── config/
│   ├── backend_clipboard.yml
│   ├── default.yml
│   ├── disable.yml
├── ignore/
│   ├── global_vars.json
│   └── global_vars.yml
├── match/
│   ├── base.yml
│   ├── shell.yml
│   ├── emoji.yml
│   ├── form.yml
│   ├── chrome.yml
│   ├── llm.yml
│   ├── english_guideline.yml
│   ├── japanese_guideline.yml
│   ├── text.yml
│   ├── math.yml
│   ├── physics.yml
│   ├── md.yml
│   ├── python.yml
│   ├── open.yml
│   ├── file.yml
│   ├── save_clipboard.yml
│   ├── touchID.yml
│   └── utils.yml
├── scripts/
│   └── json_to_yml.sh
└── state/
    └── state_focus.txt
```

Local/private files under `ignore/` are intentionally excluded from Git.
