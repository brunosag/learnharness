<!-- BEGIN:nextjs-agent-rules -->

# This is NOT the Next.js you know

This version has breaking changes — APIs, conventions, and file structure may all differ from your training data. Read the relevant guide in `node_modules/next/dist/docs/` (resolved from this file's directory; in monorepos the `next` package may not be visible from the repo root) before writing any code. Heed deprecation notices.

This block is written and re-added by `next dev` — verify at `node_modules/next/dist/server/lib/generate-agent-files.js`. Removing it from a diff only re-creates the uncommitted change; committing it with your work keeps the tree clean.

<!-- END:nextjs-agent-rules -->

# No guessing

All design authority belongs to the human. **Never guess a design or implementation decision.** If anything is ambiguous — naming, behavior, data shapes, UX, defaults, scope boundaries, prompt wording — STOP and ask with the ask-user-question tool before proceeding. If you are "a little unsure," you are unsure: ask. A wrong guess is far more expensive than a question. Ask early, ask specific, one question per call.

Concretely: first investigate and plan rigorously (asking the user design questions along the way), get the plan approved by the user, and only then implement. Implementation should be mechanical execution of an approved plan — not interpretation.

# Fork (brunosag/learnharness)

Claude runs on the user's subscription only, through the CLIProxyAPI pool on the VPS (`cliproxy.service`, `https://vps.tailcf3a8a.ts.net:8318`). Anthropic bills a subscription token sent straight from a third-party app (pi-ai included) as extra usage, not plan limits, so never paste a `claude setup-token` token into the Anthropic key field. `.env.local` sets `LH_ANTHROPIC_BASE_URL` to the pool and `ANTHROPIC_API_KEY` to the pool's client key (`access.api-keys` in `~/.config/cliproxy/config.yaml` on the VPS); `src/agent/models.ts` routes the Anthropic provider there. Run from source with `npm run dev`, without this machine's `ANTHROPIC_*` variables in the environment (real env overrides `.env.local`).

- `npm test` writes fixture sessions into `data/`, the dev data root; point `LH_DATA_DIR` elsewhere for real use or clear `data/` after testing.
- `tests/render-sidebar.test.tsx` "the meta line" also fails on upstream.
- Sync with `git fetch upstream && git rebase upstream/main`.
