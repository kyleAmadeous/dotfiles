<!-- ai-instructions-version: 2026.09.26-3 | history: git log -- shared/ai (dotfiles) -->
# Shared working agreements

@~/.codex/AGENTS.md

Keep changes tied to the user's requested outcome. Preserve surrounding code and unrelated work; use the selected repository's actual instructions and runtime tools.

## Claude Code delegation

This section supersedes the provider-specific mechanics in the imported agreements. The intent there holds; the tool names there are Codex's and do not exist here.

**Default is direct work.** The main session owns the request, integration, and final verification, and completes small, clear work itself. `Explore → Worker → Reviewer` is not a required sequence. Do not create an agent merely because a role is defined; delegate only when independent implementation, broad exploration, or independent review earns the handoff and the repeated context.

**Which agent.** Read-only exploration uses the built-in `Explore`. Ordinary bounded implementation uses the default agent with an explicit brief — no dedicated worker preset. Independent review uses `~/.claude/agents/reviewer.md`, which exists because nothing built-in fills that role; it is invoked by explicit delegation, not by keyword.

**Context.** Omitting `subagent_type` or naming any type other than `fork` starts the agent fresh — that is the default and the Codex `fork_turns="none"` equivalent. `subagent_type: "fork"` inherits the full conversation and always runs the parent's model, so a `model` override is ignored there. There is no partial-turn handoff: when a fresh agent needs history, put the necessary evidence in the prompt rather than forking for it.

**Brief.** Every delegation states the goal, working directory, owned files, prohibited actions, relevant evidence, and completion checks.

**Model and effort** come from the agent definition's frontmatter or the `model` parameter, whose values are the short aliases `sonnet` / `opus` / `haiku` / `fable` — full model IDs fail validation. Choose per role, complexity, and blast radius rather than inheriting the parent by default; implementation Sonnet or Opus, independent review and merge decisions Opus, product/copy/design judgement Fable.

**No peer-to-peer.** Agents communicate only with the session that spawned them. `SendMessage` is used solely to continue a subagent this session started, with its context intact — the equivalent of a Codex follow-up task, and the way to reuse the same worker for fixes to the same change. Do not address another session, a teammate, or a cloud session; do not create teams or spawn teammates. Agent teams stay unconfigured (they are opt-in through `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS`, so leave that variable unset rather than setting it to a falsy value).

**Isolation.** A `tools:` allowlist is the only real restriction on a subagent; role wording alone enforces nothing, and an agent holding `Bash` can still write. Subagent definitions here omit `Agent` and `SendMessage`, so they cannot nest or reach peers. `isolation: "worktree"` creates a *temporary* worktree that is auto-cleaned when unchanged — useful for throwaway parallel work, wrong for branch-and-PR work, which keeps the named `~/devsrc/<repo>-wt/<branch-slug>/` worktrees from the shared agreements. One mutating owner per worktree; never let two agents edit the same files concurrently.

**Concurrency** is capped by `CLAUDE_CODE_MAX_CONCURRENT_SUBAGENTS` in `~/.claude/settings.json`. It is a parallelism limit, not a token budget, and delegation does not by itself save tokens.
