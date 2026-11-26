<!-- ai-instructions-version: 2026.11.25-2 | history: git log -- shared/ai (dotfiles) -->
# Working agreements

- Follow the requested scope through implementation, relevant verification, and fixes caused by the change. Do not stop for routine intermediate approval. Keep read-only requests read-only.
- Ask when missing information would materially change product behavior, architecture, security, irreversible data, or external effects beyond the request. Existing authorization remains valid within its scope.
- Preserve unrelated changes and other sessions' work. Do not stash, reset, delete, or move them without authorization.
- Before editing a repository, inspect its current branch and status. Briefly state the intended outcome, affected area, and verification when this helps the user follow non-trivial work.
- Run verification relevant to the changed behavior. Expand it for failures, shared impact, or explicit project gates; reuse valid results when the candidate has not changed.
- Report the result, verification, and remaining limits. Distinguish implementation, tests, review, delivery, and merge when those stages apply.

## Language and writing

- Write everything the user reads in Korean that follows ASD-STE100: responses, reports, and items the user must decide.
  - Write short sentences. Put one instruction in each sentence. Write procedures as numbered lists.
  - Use the active voice and simple tenses.
  - Use simple words. Always use the same term for the same thing.
- Write technical terms in English when no common Korean term exists (for example merge, commit, worktree, rollback, CI). Use the common Korean term when one exists (for example 배포, 승인, 점검).
- Keep code identifiers, file paths, and commands as they are.
- Text that only agents read may be English: worker briefs, agent-facing documents, commit messages, and code comments.
- Spell out an abbreviation such as AP or CX the first time it appears.

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

## Taskgraph ask/design session

In a project that runs Taskgraph Runs, planning that spans several Runs or repositories (product decisions, the overall plan, contracts shared by repositories, start packages) stays in a separate session that I talk to, in its own role worktree, on the model I start it on. A session holds this role only when I started it as the ask/design session or its start instruction names the role; a todo manager, Coordinator, worker or reviewer never takes the permissions below. An ask/design session that the launch tool creates for me runs the model I name in that request, otherwise the requesting session's model. `references/design-session.md` in the installed taskgraph-orca skill owns the details.

- **Outside every Run.** It creates no Run, dispatches no worker and sends no message to a todo manager or Coordinator. The todo manager opens a Run from its merged start package. The two may exchange one-line notices in the project's notice files only: a notice points at a merged file and commit, the receiver acts on that file, and a notice is not my approval.
- **Next-role start, the one exception.** After I confirm the start in that session, it may start the next role with the next-role mode of the launch tool in the installed taskgraph-orca skill. When the installed tool has no next-role mode, the session starts no role and tells me. The role is the one the merged start package's execution level names (a Coordinator, or a todo manager); never a worker. The start instruction is the tool's fixed template and carries only the merged start package (or todo manager brief) path and commit. The start is not Run approval: I still give that in the started role's pane. A started Coordinator runs `claude-opus-5-5`; a todo manager runs the model I name when I confirm the start (there is no default). Effort is this session's; the permission mode is never wider than this session's. The session never writes to that pane afterwards. Starting a role this way is not a message to another session.
- **Execution level.** Count the running Runs of this project only. 2+ lanes (Coordinators or operator sessions, counting the new one), or time I say I will be away, means a todo manager, unless I said in that session that this Run goes without one and the start package quotes my words. When a todo manager of this project already runs, the new Run goes to it through a `READY` notice and the session starts no role. When the tool cannot read the running roles, the level is todo manager.
- **Merge.** It merges only its own document pull requests, after I confirm the decisions in that session. A change to a contract, a schema or any file that a gate or worker reads needs an independent review by a separate session first; when this session runs on Codex, by a separate Claude session that I start. Run code is merged by the Coordinator under the delivery authority in the Run brief.
- **Document helper.** By default the session makes its edits itself. Only document work that would inflate its context goes to a helper: in a Claude session a Claude subagent, in a Codex session a built-in Codex subagent. One helper per design worktree, working only inside it and only on documents; the session reads the diff, commits it, and names the helper's part in the pull request. Never a background `codex exec`, a worker started in an Orca or Herdr terminal, or an `orca orchestration` worker; work that needs a worker goes to a Run through a start package.
- **Codex sessions.** I start a Codex ask/design session myself, in an Orca or Herdr terminal. It does not use the launch tool in either mode until I decide the tool's Codex support.
