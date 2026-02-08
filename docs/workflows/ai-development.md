# AI Development Workflows

The AI Dev Workstation provides a structured environment designed to facilitate collaboration between human developers and multiple AI agents.

## The 3-Tab Strategy

The default `ai_workstation` layout is designed around a three-stage cognitive process: **Reasoning**, **Implementation**, and **Execution**.

### Tab 1: Core Agents (Reasoning & Architecture)
**Focus:** High-level planning, documentation lookup, and architectural decisions.

*   **Left Pane (Gemini):** Use this for broad knowledge retrieval, documentation explanation, and algorithm design. Gemini's large context window makes it ideal for holding the "whole project" context.
*   **Right Pane (Claude):** Use this for complex reasoning, architectural critiques, and refactoring strategies. Claude excels at "thinking through" problems.

**Workflow:**
1.  Paste a problem statement into Claude.
2.  Ask Gemini to find relevant documentation or libraries.
3.  Synthesize a plan before writing any code.

### Tab 2: Support (Implementation)
**Focus:** Generating code, writing tests, and specific function implementations.

*   **Codex/Copilot CLI:** Use for generating boilerplate, unit tests, or specific function blocks.
*   **OpenCode:** A secondary assistant for reviewing code snippets or alternative implementations.

**Workflow:**
1.  Take the plan from Tab 1.
2.  Ask Codex to generate the skeleton code.
3.  Copy the code to your clipboard.

### Tab 3: Terminal (Execution)
**Focus:** File management, git operations, and running servers.

*   **Shell:** The standard command line. Use this to run tests, start servers, or manage files.
*   **Git (LazyGit):** A full-screen UI for managing git commits, branches, and diffs.

## Typical Cycle

1.  **Start:** `of start my-project` (Opens Editor on Windows + AI Terminals).
2.  **Tab 1:** Discuss the feature with Claude. Agree on an interface.
3.  **Tab 2:** Generate the implementation details.
4.  **Windows Editor:** Paste code, refine, and save.
5.  **Tab 3:** Run tests (`npm test` / `cargo test`). Use LazyGit to stage and commit changes.
6.  **Loop:** Repeat.

## Context Switching

Use Zellij shortcuts to move rapidly between these contexts:
*   `Alt + Left/Right`: Switch Tabs.
*   `Alt + h/j/k/l`: Move focus between panes within a tab.
