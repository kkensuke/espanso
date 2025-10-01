# My Espanso Configuration

This repository contains a personal collection of powerful [Espanso](https://espanso.org/) snippets designed to boost productivity in coding, writing, and daily tasks. It heavily leverages shell scripting, LLM APIs, and application automation to create a highly efficient workflow on macOS.


## ✨ Key Features
- **🤖 LLM‑Powered Workflows**: Direct integration with the Google Gemini API for on‑the‑fly translation, grammar correction, rephrasing, summarization, and custom prompts — all without leaving your current application.
- **🚀 Application & Web Automation**: Smartly switch to existing browser tabs (or open new ones) for frequently used sites like ChatGPT, GitHub, and Slack. Quickly open project folders in your editor or terminal.
- **📋 Clipboard Management**: Save, organize, and retrieve clipboard content with persistent storage and easy management.
- **🔍 Trigger Discovery**: Automatically index and search through all your triggers across files for easy discovery and management.
- **⚙️ Configuration Management**: Tools for managing global variables and converting between JSON and YAML formats.
- **🛠️ Powerful Utilities**: A suite of tools at your fingertips, including:
    - Opening URLs with search queries from the clipboard (`chrome.yml`)
    - Opening repositories in VS Code (`open.yml`)
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

Keep your API key secure and don't share it publicly. Add `match/params.yml` to your `.gitignore` to avoid committing it by accident if you use GitHub.


## Snippet Guide
The snippets are organized into logical files in the `match/` directory:

| File                     | Description                        |
| ------------------------ | ---------------------------------- |
| **Utilities**     |    |
| `base.yml`               | Global variables (clipboard, dates) and the work/personal state toggle.              |
| `utils.yml`              | General utilities: path copying, currency conversion, dictionary lookup, etc.        |
| `text.yml`               | Text manipulation: greetings, case conversion, etc.  |
| `open.yml`               | Open projects, create files, convert URLs to Markdown.      |
| `save_clipboard.yml`     | Clipboard management: save, organize, and retrieve clipboard history with timestamps. |
| **Application Specific** |    |
| `chrome.yml`             | Smart tab switching/opening for common sites (ChatGPT, GitHub, Slack, YouTube, etc.) |
| `tabchange.yml`          | AppleScript for smart tab switching (used by `chrome.yml`).                          |
| `python.yml`             | Python code snippets.              |
| `md.yml`                 | Markdown shortcuts for links, code blocks, etc.      |
| **LLM**        |    |
| `llm.yml`                | Core LLM integration: translation, rephrasing, proofreading, etc.                |
| `english_guideline.yml`  | Academic English writing checklist (used by `llm.yml`).                              |
| `japanese_guideline.yml` | Academic Japanese writing checklist (used by `llm.yml`).                             |
| **Configuration Management** |    |
| `json_global_vars.yml`   | Dynamic global variable management from JSON files with forms for easy editing.       |
| `trigger_search.yml`     | Search and browse triggers across all files with indexing capabilities.              |
| **Symbols**       |    |
| `math.yml`               | Math symbols, Greek letters, and simple calculations.|
| `emoji.yml`              | Common emojis and special keyboard symbols.          |


## 🌟 Featured Snippets
Here are some examples of the most powerful snippets. They use the clipboard text as input:
| Trigger        | Action      |
| -------------- | ----------- |
| `;jet`         | Translate clipboard content to English via Gemini. |
| `;ejt`         | Translate clipboard content to Japanese via Gemini. |
| `;gpt`         | Switch to the ChatGPT tab if open, otherwise open a new one. (`;gai` for Google Gemini, `;claude` for Claude.) |
| `;cdgh`        | Shows a form with a list of your repos in `~/github/` and opens the selected one in VS Code.        |
| `;case`        | Open a form to convert the clipboard text to `UPPERCASE`, `lowercase`, `camelCase`, `snake_case`, etc.    |
| `;clippath`    | Copy the POSIX path of the selected file/folder in Finder.            |
| `;state;focus` | Toggles the state between "WORK" and "PERSONAL" by updating `state/state_focus.txt`. You can use this to change the behavior of other snippets based on the current state.       |


## 📋 Clipboard Management
The `save_clipboard.yml` file provides persistent clipboard management with timestamps:

| Trigger      | Action      |
| ------------ | ----------- |
| `;additem`   | Save current clipboard content to a persistent list with timestamp |
| `;showlist`  | Display all saved clipboard items with timestamps |
| `;delitem`   | Select and delete a specific item from the saved list |
| `;dellist`   | Clear the entire clipboard history |

All clipboard items are stored in `state/clipboard_list.md` with timestamps for easy reference and organization. It is recommended to add this file to your `.gitignore` to avoid committing sensitive information.

## 🔍 Trigger Discovery & Management
The repository includes powerful tools for managing and discovering your triggers:

### Trigger Indexing
Run the `generate_trigger_index.sh` script to create a comprehensive JSON index of all your triggers:

```bash
sh generate_trigger_index.sh
```

This script:
- Scans all `.yml` files in your `match/` directory
- Extracts triggers using multiple methods (simple triggers, trigger arrays, regex patterns)
- Creates a JSON index with trigger counts per file
- Provides statistics on your trigger collection
- Outputs to `state/trigger_index.json`

### Trigger Search & Browse
Use these triggers to explore your trigger collection:

| Trigger           | Action      |
| ----------------- | ----------- |
| `;triggers`       | Browse triggers by file with a selection form |
| `;findtrigger`    | Search for specific triggers across all files |
| `;alltrigger`     | Show all available triggers in a numbered list |
| `;triggerfiles`   | Overview of all files and their trigger counts |
| `;updatetrigger`  | Run the trigger indexing script to refresh the index |


## ⚙️ Configuration Management

### Global Variables from JSON
The `json_global_vars.yml` file allows you to manage global variables dynamically using a JSON configuration file:

1. **Setup**: Create a `config/global_vars.json` file (see `config/global_vars_examples.json` for structure)
2. **Use the triggers**:

| Trigger      | Action      |
| ------------ | ----------- |
| `;var`       | Quick access to any variable with a selection form |
| `;getvar`    | Get a variable value by category and key |
| `;setvar`    | Add or update a variable in the JSON file |
| `;showcat`   | Show all variables in a specific category |
| `;allvar`    | Display overview of all categories and variables |
| `;newcat`    | Create a new category in the JSON file |
| `;delvar`    | Delete a specific variable |

### JSON to YAML Conversion
Use the `json_to_yml.sh` script to convert your JSON configuration to YAML format:

```bash
sh json_to_yml.sh
```

This script:
- Reads from `config/global_vars.json`
- Generates properly formatted YAML with global_vars and matches sections
- Automatically creates triggers for each variable (`;VARIABLE_NAME` → `{{VARIABLE_NAME}}`)
- Organizes output by categories with clear headers

Both `config/global_vars.json` and `match/global_vars.yml` should be added to your `.gitignore` to avoid committing sensitive information.


## 🛠️ Helper Scripts

### `generate_trigger_index.sh`
- **Purpose**: Creates a searchable JSON index of all triggers across your configuration files
- **Output**: `state/trigger_index.json` with trigger counts and file organization
- **Features**: Supports simple triggers, trigger arrays, and regex patterns
- **Usage**: Run manually or via `;updatetrigger` to refresh the index

### `json_to_yml.sh`
- **Purpose**: Converts JSON global variables to Espanso YAML format
- **Input**: `config/global_vars.json`
- **Output**: Properly formatted YAML for use as `match/global_vars.yml`
- **Features**: Auto-generates both variable definitions and corresponding triggers


## 📁 File Structure
```
📁 File Structure
├── .gitignore                           # Git ignore file (excludes sensitive configs)
├── README.md                            # Main documentation (this file)
├── config/                              # Configuration files
│   ├── default.yml                      # Espanso global configuration
│   └── global_vars_examples.json        # Example JSON structure for variables
├── match/                               # All snippet files
│   ├── base.yml                         # Basic global variables and state toggle
│   ├── example.yml                      # Example snippets (passwords, UUIDs, etc.)
│   ├── form.yml                         # Form examples and TODO templates
│   ├── emoji.yml                        # Common emojis and special keyboard symbols
│   ├── math.yml                         # Math symbols, Greek letters, calculations
│   ├── english_guideline.yml            # Academic English writing checklist
│   ├── japanese_guideline.yml           # Academic Japanese writing checklist
│   ├── chrome.yml                       # Browser automation and tab switching
│   ├── tabchange.yml                    # AppleScript for Chrome tab switching (used by `chrome.yml`)
│   ├── md.yml                           # Markdown shortcuts and formatting
│   ├── physics.yml                      # Physics notation (quantum states, etc.)
│   ├── python.yml                       # Python code snippets and templates
│   ├── llm.yml                          # LLM integration (Gemini API)
│   ├── open.yml                         # File/directory opening and project management
│   ├── text.yml                         # Text manipulation and case conversion
│   ├── json_global_vars.yml             # Dynamic variable management from JSON
│   ├── trigger_search.yml               # Trigger discovery and search tools
│   ├── save_clipboard.yml               # Clipboard management and history
│   └── utils.yml                        # General utilities and tools
├── state/                               # Runtime state and data storage
│   ├── clipboard_list_examples.md       # Example saved clipboard items
│   ├── state_focus.txt                  # Current work/personal state
│   └── trigger_index_examples.json      # Example generated trigger index
├── generate_trigger_index.sh            # Script to index all triggers
└── json_to_yml.sh                       # Script to convert JSON to Espanso global variables (YAML)
```

## 🎯 Getting Started Tips

1. **Start Small**: Begin with basic triggers like `;date`, `;gpt`, and `;case` to get familiar
2. **Set Up Clipboard Management**: Use `;additem` to start building your clipboard history
3. **Index Your Triggers**: Run `generate_trigger_index.sh` and use `;triggers` to explore available snippets
4. **Configure Global Variables**: Create your `config/global_vars.json` for personalized snippets
5. **Explore by Category**: Use `;triggerfiles` to see what's available in each file
6. **Customize for Your Workflow**: Modify triggers and add your own based on your specific needs

After adding new snippets, run `;updatetrigger` to keep your trigger index up-to-date.
