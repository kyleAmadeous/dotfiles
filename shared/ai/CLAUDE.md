<!-- ai-instructions-version: 2026.11.10-2 | history: git log -- shared/ai (dotfiles) -->
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

**Fable and Opus roles.** Split by how correctness is judged, not by difficulty. This is a working hypothesis from vendor positioning and use, not a measured result.
- Fable: work judged by how a person sees or experiences it — product priorities, screen and flow design, empty/error/loading states, placeholder and other visible copy, qualitative review. Keep it out of code implementation and pass/fail gates.
- Opus: work judged by verifiable conditions — data contracts, IME/sanitize/flag/concurrency design, test criteria, mechanical review and merge decisions.
- Give Fable a fixed evidence bundle (screenshots, verified facts) and written criteria; it does not collect facts itself. Ask for issues with reasons, not a verdict. Its output informs a human decision and is never the sole gate; fact-check its factual claims with Opus or the implementation model.
- An item that crosses the boundary (for example a placeholder whose visibility depends on IME composition) gets the Fable design first, then an Opus check of the technical conditions.
- Fable costs about 2.5× Opus per token; keep it on short, judgment-heavy work.
- Games (casual, slots): Fable takes game feel — win-tier and bonus anticipation presentation, reward/level-clear screens, onboarding friction, paytable/help and shop copy, whether monetization feels pushy. Opus takes RTP, volatility, reel strips, paytable values, difficulty curves and economy (by calculation or simulation), RNG, server-result/presentation consistency, balance and payment handling, and regulatory rules such as not presenting a win below the bet as a win or autoplay limits; a human makes the final regulatory call. Give Fable frame sequences, video or timing values for motion — a still frame cannot show feel — and confirm feel and fun by human playtest and metrics, not by Fable alone. Where presentation meets numbers (for example the bet multiple that triggers Big Win), Fable proposes the feel and Opus checks thresholds and rules; any Fable proposal that hides losses or encourages excessive play is rejected.

**No peer-to-peer.** Agents communicate only with the session that spawned them. `SendMessage` is used solely to continue a subagent this session started, with its context intact — the equivalent of a Codex follow-up task, and the way to reuse the same worker for fixes to the same change. Do not address another session, a teammate, or a cloud session; do not create teams or spawn teammates. Agent teams stay unconfigured (they are opt-in through `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS`, so leave that variable unset rather than setting it to a falsy value).

**Isolation.** A `tools:` allowlist is the only real restriction on a subagent; role wording alone enforces nothing, and an agent holding `Bash` can still write. Subagent definitions here omit `Agent` and `SendMessage`, so they cannot nest or reach peers. `isolation: "worktree"` creates a *temporary* worktree that is auto-cleaned when unchanged — useful for throwaway parallel work, wrong for branch-and-PR work, which keeps the named `~/devsrc/<repo>-wt/<branch-slug>/` worktrees from the shared agreements. One mutating owner per worktree; never let two agents edit the same files concurrently.

**Concurrency** is capped by `CLAUDE_CODE_MAX_CONCURRENT_SUBAGENTS` in `~/.claude/settings.json`. It is a parallelism limit, not a token budget, and delegation does not by itself save tokens.

## Taskgraph provider delegation

This is a standing user delegation for Taskgraph work only (`taskgraph-solo` / `taskgraph-orca` Runs); it does not apply to other conversations or to small edits made outside a Run.

- **Coordinator:** the current Claude Code session (Opus) owns the Spec, Task split, integration, acceptance and final verification, and makes small, clear edits itself.
- **Long Orca+ Runs:** for an authorized `taskgraph-orca` execution Run (not read-only or planning-only work) with 3+ Tasks, 2+ concurrent workers, 2+ hours, or time the user says they will be away, decided before the Run is created: the current session becomes the todo manager, drafts the Spec, and places a Claude Coordinator with this session's model and effort in its own worktree without asking again; that Coordinator then owns the duties above. Both roles rotate themselves near their context threshold. The skill's `references/session-rotation.md` owns the details.
- **Implementation:** Codex workers. Select the model and supported effort per Task from the Taskgraph Codex lanes, using `gpt-6.1-sol`, `gpt-6-astra` and `gpt-6-luna`; pass the selection explicitly and verify it from the rollout.
- **Independent review:** a separate Claude session, not the Coordinator, using `claude-opus-5-5` or `claude-sonnet-5-5` per the review lane; planning and design judgement may use `claude-fable-5-1`.
- Apply this within existing Task, Dispatch, Eval, time and cost limits without asking again. Explicit instructions in the request or project take precedence, and paid calibration or experiments still need their own approval.
