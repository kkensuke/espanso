# My Espanso Configuration

This repository contains a personal collection of powerful [Espanso](https://espanso.org/) snippets designed to boost productivity in coding, writing, and daily tasks. It heavily leverages shell scripting, LLM APIs, and application automation to create a highly efficient workflow on macOS.


## ✨ Key Features
- **🤖 LLM‑Powered Workflows**: Direct integration with the Google Gemini API for on‑the‑fly translation, grammar correction, rephrasing, summarization, and custom prompts — all without leaving your current application.
- **🚀 Application & Web Automation**: Smartly switch to existing browser tabs (or open new ones) for frequently used sites like ChatGPT, GitHub, and Slack. Quickly open project folders in your editor or terminal.
- **🛠️ Powerful Utilities**: A suite of tools at your fingertips, including:
    - Opening URLs with search queries from the clipboard (`chrome.yml`)
    - Opening repositories in VS Code (`open.yml`)
    - Creating new files (`open.yml`)
    - Text case conversion (`text.yml`)
    - Copying POSIX paths of files/folders (`utils.yml`)
    - Password, UUID, and hash generators (`example.yml`)
    - URL shortener (`utils.yml`)
    - Basic math calculations (`math.yml`)
    - Dictionary lookup (`utils.yml`)
    - Currency converter (`utils.yml`)
    - And more


## 🚀 Installation & Setup
### 1. Install Espanso
First, make sure Espanso is installed on your system. See the [official Espanso installation guide](https://espanso.org/install/).


### 2. Configuration
Copy any triggers you want from this repository into your Espanso configuration directory. To find your current config path, run:

```bash
espanso path
```

On macOS, the default path is usually:

```
$HOME/Library/Application Support/espanso/match/base.yml
```

By default you only have `base.yml` in your `match/` directory, but you can add more `.yml` files to organize your snippets. Espanso will load them all automatically.


### 3. Set Up Dependencies
This repository relies on a few command‑line tools. If you use [Homebrew](https://brew.sh) on macOS, install them with:

```bash
brew install jq
```

It also uses macOS‑specific tools like `osascript` and `open`.


### ⚠️ 4. Add Your Gemini API Key
Many powerful snippets (translation, proofreading, etc.) use the Google Gemini API. To add your key:
1. Get a free API key from [Google AI Studio](https://aistudio.google.com/app/apikey).
2. Make `match/params.yml` and paste the `GEMINI_API_KEY` global variable there.
3. Replace the `YOUR_REAL_GEMINI_API_KEY_HERE` with your actual key:

```yaml
# In match/params.yml
global_vars:
  - name: GEMINI_API_KEY
    type: echo
    params:
      # ⬇️ REPLACE THIS WITH YOUR REAL KEY ⬇️
      echo: "YOUR_REAL_GEMINI_API_KEY_HERE"
```

Keep your API key secure and don’t share it publicly. Add `match/params.yml` to your `.gitignore` to avoid committing it by accident if you use GitHub.


## Snippet Guide
The snippets are organized into logical files in the `match/` directory:

| File                     | Description                        |
| ------------------------ | ---------------------------------- |
| **Utilities**     |    |
| `base.yml`               | Global variables (clipboard, dates) and the work/personal state toggle.              |
| `utils.yml`              | General utilities: path copying, currency conversion, dictionary lookup, etc.        |
| `text.yml`               | Text manipulation: greetings, case conversion, etc.  |
| `open.yml`               | Open projects, create files, convert URLs to Markdown.      |
| **Application Specific** |    |
| `chrome.yml`             | Smart tab switching/opening for common sites (ChatGPT, GitHub, Slack, YouTube, etc.) |
| `tabchange.yml`          | AppleScript for smart tab switching (used by `chrome.yml`).                          |
| `python.yml`             | Python code snippets.              |
| `latex.yml`              | LaTeX boilerplate for environments like `figure`, `align`, and `theorem`.            |
| `md.yml`                 | Markdown shortcuts for links, code blocks, etc.      |
| **LLM**        |    |
| `llm.yml`                | Core LLM integration: translation, rephrasing, proofreading, etc.                |
| `english_guideline.yml`  | Academic English writing checklist (used by `llm.yml`).                              |
| `japanese_guideline.yml` | Academic Japanese writing checklist (used by `llm.yml`).                             |
| **Symbols**       |    |
| `math.yml`               | Math symbols, Greek letters, and simple calculations.|
| `emoji.yml`              | Common emojis and special keyboard symbols.          |


## 🌟 Featured Snippets
Here are some examples of the most powerful snippets. They use the clipboard text as input:
| Trigger        | Action      |
| -------------- | ----------- |
| `;transen`     | Translate clipboard content to English via Gemini. |
| `;transja`     | Translate clipboard content to Japanese via Gemini. |
| `;gpt`         | Switch to the ChatGPT tab if open, otherwise open a new one. (`;gai` for Google Gemini, `;claude` for Claude.) |
| `;cdgh`        | Shows a form with a list of your repos in `~/github/` and opens the selected one in VS Code.        |
| `;case`        | Open a form to convert the clipboard text to `UPPERCASE`, `lowercase`, `camelCase`, `snake_case`, etc.    |
| `;clippath`    | Copy the POSIX path of the selected file/folder in Finder.            |
| `;state;focus` | Toggles the state between "WORK" and "PERSONAL" by updating `state/state_focus.txt`. You can use this to change the behavior of other snippets based on the current state.       |
