<!-- ai-instructions-version: 2026.09.26-3 | history: git log -- shared/ai (dotfiles) -->
# Working agreements

- Follow the requested scope through implementation, relevant verification, and fixes caused by the change. Do not stop for routine intermediate approval. Keep read-only requests read-only.
- Ask when missing information would materially change product behavior, architecture, security, irreversible data, or external effects beyond the request. Existing authorization remains valid within its scope.
- Preserve unrelated changes and other sessions' work. Do not stash, reset, delete, or move them without authorization.
- Before editing a repository, inspect its current branch and status. Briefly state the intended outcome, affected area, and verification when this helps the user follow non-trivial work.
- Run verification relevant to the changed behavior. Expand it for failures, shared impact, or explicit project gates; reuse valid results when the candidate has not changed.
- Report the result, verification, and remaining limits. Distinguish implementation, tests, review, delivery, and merge when those stages apply.

## Repositories under ~/devsrc

- Treat main/master checkouts as baselines: inspect, fetch, pull, and perform authorized post-merge cleanup there. Make tracked edits in a task branch and worktree; use one mutating owner per worktree.
- Use `<type>/<author>/<scope>-<slug>` branches and `~/devsrc/<repo>-wt/<branch-slug>/`. Preserve existing task worktrees when resuming the same task.
- For integration worktrees, release bundles, ownership conflicts, or shared protocol/build changes, consult `~/devsrc/kyle-claude-plugins/kyle-workflow/knowledge/worktree-strategy.md`.
- For cross-project knowledge about MetaBet or tableGame-next, consult Knowledge OS when repository evidence leaves a relevant gap. It is a personal generated wiki, not project authority. Its query tool writes a draft to `outputs/`; use source inspection for strictly read-only work.
- Modify reusable skill/plugin sources before installing their updated copies. Verify installation; old sessions can retain earlier instructions.

## Adaptive delegation

- The main agent owns the current task, integration, and final verification. Complete small, clear work directly; do not require an Explorer → Worker → Reviewer sequence.
- Delegate concrete, bounded work when independent implementation, broad exploration, or independent review adds enough value to justify handoff and repeated context. For exploration or implementation, continue useful independent work while the subagent runs.
- Decide delegation by workload, not difficulty. A fresh worker has a large fixed cost to rebuild its context, so keep small edits, records and delivery in the main session. Hand off work that would inflate the main context, such as multi-file implementation with repeated test runs or broad exploration where only the conclusion matters, and work that needs independent review.
- Keep tightly coupled investigation and implementation with one owner. Reuse that worker for fixes to the same change before spawning a replacement.
- Each delegation states the goal, working directory, owned files, constraints, relevant evidence, and completion checks. Prefer `fork_turns="none"` when this brief is sufficient; otherwise pass the necessary recent turns. Use full history only when summarizing would lose essential decisions, and respect the tool's model-override restrictions.
- Use the configured medium reasoning default for ordinary delegated work; increase it for difficult diagnosis, complex implementation, or high-impact review. Select supported models for task complexity and project requirements rather than always inheriting the main model.
- Assign one mutating owner per worktree and never let workers edit the same files concurrently. Delegation does not create filesystem isolation. Explorer and Reviewer are read-only roles; instructions alone do not enforce a sandbox.
- Use an independent Reviewer for changes with substantial security, permission, data-loss, concurrency, or hard-to-verify risk. Require concrete findings and relevant verification; review alone is not proof of completion. Follow project-specific required reviews and gates.
- Role files in `~/.codex/agents/{explorer,worker,reviewer}.toml` are optional presets. If the current spawn tool has no role selector, read only the chosen role file and put its instructions in the task message and explicitly select the model and reasoning as needed. Do not claim the preset was loaded.
- Keep one coherent task in one main session. Record durable decisions concisely in project documents; start unrelated goals separately. Avoid repeated investigation or verification when existing evidence still applies. Concurrency limits are not token budgets, and delegation does not guarantee token savings.

## Design decisions across tools

- For new UI or substantial visual changes, follow the design-decisions reference in the taskgraph-solo/taskgraph-orca skills: one brief and one primary design owner per deliverable, skills chosen from what the active session actually exposes (Codex and Claude differ), trends as optional candidates, and evaluation and repair inside the existing task limits. Small fixes need only relevant checks.
