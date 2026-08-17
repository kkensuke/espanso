# My Espanso Configuration

Personal [Espanso](https://espanso.org/) configuration for macOS, with snippets for writing, coding, browser/app shortcuts, scientific notation, clipboard workflows, and LLM-assisted text processing.

> [!NOTE]
> This is a personal configuration rather than a plug-and-play Espanso package. Several matches assume macOS, specific applications, custom directory layouts, or private global variables. Review the files you want to use and adapt paths/apps to your environment.

## Highlights

- **LLM workflows with Google Gemini** — translate clipboard text, rephrase scientific writing, and build proofreading prompts.
- **Text and writing helpers** — Japanese greetings, character/word counts, case conversion, quoting, Markdown snippets, and reusable forms.
- **Browser and application shortcuts** — open Google, ChatGPT, Gemini, Claude, GitHub, Google Scholar, Terminal, and other apps/sites.
- **Clipboard list** — append, display, delete, and clear saved clipboard entries in a private file under `ignore/`.
- **JSON-backed variables** — browse and edit categorized values stored in `config/global_vars.json`.
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
- VS Code and the `code` CLI for project-opening snippets
- `python3` for repository/text helpers
- `uv` for the `;uvinit` Python trigger
- Aerospace for the `;gap` utility
- Google Chrome for the AppleScript-based new-tab trigger
- Personal apps referenced in `match/open.yml`, such as Shottr, Hand Mirror, and LINE

Some example snippets also rely on common Unix utilities that may differ between macOS and Linux. Check the shell command in the relevant match before using it on another platform.

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
| `config/disable.yml` | Excludes `match/global_vars_examples.yml` from normal loading. |
| `config/global_vars_examples.json` | Example categorized JSON data used by the conversion script. |

## Match Guide

| File | Purpose |
| --- | --- |
| `match/base.yml` | Shared clipboard/date variables, private imports, `;date`, `;now`, restart helper, and WORK/PERSONAL state toggle. |
| `match/chrome.yml` | Browser/site shortcuts including Google, ChatGPT, Gemini, Claude, GitHub, Scholar, YouTube, and Chrome helpers. |
| `match/emoji.yml` | macOS keyboard symbols, emoji shortcuts, and an emoji picker form. |
| `match/english_guideline.yml` | Academic English checklist exposed as the `english_guideline` global variable. |
| `match/example.yml` | Shell, IP lookup, UUID/password/hash, random, and other example snippets. |
| `match/form.yml` | Espanso form examples and a TODO form. |
| `match/global_vars_examples.yml` | Generated example globals/triggers from `config/global_vars_examples.json`; excluded by `config/disable.yml`. |
| `match/japanese_guideline.yml` | Japanese writing guideline exposed as the `japanese_guideline` global variable. |
| `match/json_global_vars.yml` | Read, browse, add, update, and delete values in `config/global_vars.json`. |
| `match/llm.yml` | Gemini API integration for translation, rephrasing, and proofreading prompt helpers. |
| `match/math.yml` | Greek letters, mathematical symbols, set/calculus/logic notation, and simple regex calculations. |
| `match/md.yml` | Markdown/code-block and documentation shortcuts. |
| `match/open.yml` | Open apps/projects, select a local repo, create a memo/URL shortcut, and convert a webpage URL to Markdown. |
| `match/physics.yml` | Quantum notation such as ket, bra, inner product, and expectation value. |
| `match/python.yml` | Python imports, environment commands, class/file/pickle templates, and plotting snippets. |
| `match/save_clipboard.yml` | Persistent clipboard list stored in `ignore/clipboard_list.md`. |
| `match/text.yml` | Greetings, text cleanup, counts, quoting, and case conversion. |
| `match/touchID.yml` | Example `kctouch` integration for retrieving a Keychain secret after Touch ID authentication. |
| `match/utils.yml` | macOS/Finder/system helpers, URL shortening, dictionary lookup, currency conversion, and personal workflow utilities. |

## Featured Triggers

| Trigger | Action |
| --- | --- |
| `;date` | Insert the current date as `YYYY/MM/DD`. |
| `;now` | Insert the current timestamp. |
| `;state;focus` | Toggle `state/state_focus.txt` between `WORK` and `PERSONAL`. |
| `;gpt` | Open ChatGPT. |
| `;ggl` | Search Google for the current clipboard text. |
| `;scholar` | Search Google Scholar for the current clipboard text. |
| `;jet` | Translate clipboard content to English through Gemini. |
| `;ejt` | Translate clipboard content to Japanese through Gemini. |
| `;rephrase` | Ask Gemini for three scientific-writing rephrasings of clipboard text. |
| `;case` | Convert clipboard text to upper/lower/Pascal/camel/title/kebab/snake case. |
| `;chars` / `;words` | Count clipboard characters or words. |
| `;cdgh` | Choose a directory under `{{GITHUB}}` and prepare to open it in VS Code. |
| `;additem` | Append clipboard text to the private clipboard list. |
| `;showlist` | Show all saved clipboard entries. |
| `;delitem` | Select and remove one clipboard entry. |
| `;var` | Pick any value from `config/global_vars.json`. |
| `;setvar` | Add or update a JSON-backed variable. |
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

## JSON-Backed Global Variables

`match/json_global_vars.yml` expects:

```text
{{ESPANSO}}/config/global_vars.json
```

Use `config/global_vars_examples.json` as a structure reference. The management triggers are:

| Trigger | Action |
| --- | --- |
| `;var` | Select any variable without choosing a category first. |
| `;getvar` | Select a category and variable, then insert its value. |
| `;showcat` | Show all values in a category. |
| `;allvar` | Show all categories and values. |
| `;setvar` | Add or update a value. |
| `;newcat` | Add a category. |
| `;delvar` | Delete a value. |

> [!WARNING]
> `config/global_vars.json` is **not** ignored by the current `.gitignore`. Do not put secrets there unless you also exclude the file from version control. API keys and other sensitive values are better kept under `ignore/`.

## JSON → YAML Example Generator

`scripts/json_to_yml.sh` is an example generator. It currently:

1. Reads `config/global_vars_examples.json`.
2. Generates Espanso `global_vars` and matching `;VARIABLE_NAME` triggers.
3. Writes the result to `match/global_vars_examples.yml`.

Run it with `ESPANSO` set to the configuration root:

```bash
export ESPANSO="/path/to/espanso/config-root"
./scripts/json_to_yml.sh
```

`config/disable.yml` excludes the generated example file from normal Espanso loading.

## Touch ID / Keychain

`match/touchID.yml` demonstrates retrieving a secret from the macOS Keychain with [`kctouch`](https://github.com/rgeraskin/kctouch).

After installing `kctouch`, create a Keychain entry using service/account names of your choice, then update the placeholders in `match/touchID.yml`:

```bash
kctouch add --service "YOUR_SERVICE_NAME" --account "YOUR_ACCOUNT_NAME"
```

The `;touchid` trigger uses the corresponding `kctouch get` command and requires Touch ID authentication.

## Current Repository Structure

```text
.
├── .gitignore
├── README.md
├── config/
│   ├── backend_clipboard.yml
│   ├── default.yml
│   ├── disable.yml
│   └── global_vars_examples.json
├── match/
│   ├── base.yml
│   ├── chrome.yml
│   ├── emoji.yml
│   ├── english_guideline.yml
│   ├── example.yml
│   ├── form.yml
│   ├── global_vars_examples.yml
│   ├── japanese_guideline.yml
│   ├── json_global_vars.yml
│   ├── llm.yml
│   ├── math.yml
│   ├── md.yml
│   ├── open.yml
│   ├── physics.yml
│   ├── python.yml
│   ├── save_clipboard.yml
│   ├── text.yml
│   ├── touchID.yml
│   └── utils.yml
├── scripts/
│   └── json_to_yml.sh
└── state/
    └── state_focus.txt
```

Local/private files under `ignore/` and development files under `dev/` are intentionally excluded from Git.
