# freight.ai — pre-release landing

A single-page static site for the freight.ai pre-release / early-access
announcement. No build step, no bundler, no npm, no external JavaScript —
plain HTML + CSS plus a tiny progressive-enhancement script (scroll-reveal
only; the page is fully readable without it).

## Files

| File        | Purpose                                                       |
| ----------- | ------------------------------------------------------------- |
| index.html  | The whole page                                                |
| styles.css  | All styling (CSS custom properties, dark theme)               |
| main.js     | IntersectionObserver reveal animations — optional enhancement |
| favicon.svg | Inline logo mark (lane + arrow, cyan→indigo)                  |
| deploy.sh   | One-command GitHub Pages deploy                               |

## Preview locally

From this directory:

```bash
python -m http.server 8000
```

Then open <http://localhost:8000/>. Any static file server works; opening
`index.html` directly in a browser also renders fine (no fetches, no routing).

## Deploy to GitHub Pages

All asset paths are relative (`styles.css`, `main.js`, `favicon.svg`), so the
site works under the project subpath `https://<owner>.github.io/freight-ai/`.

Option A — the script (from this directory):

```bash
bash deploy.sh
```

Option B — the two commands the script runs:

```bash
gh repo create freight-ai --public --source=. --push
gh api -X POST repos/{owner}/freight-ai/pages -f "source[branch]=main" -f "source[path]=/"
```

The site goes live at `https://<owner>.github.io/freight-ai/`.

## Content notes

- All copy comes from the project's fact sheet; every number on the page is an
  engineering fact from the codebase or a recorded test run — not a market result.
- The only outbound links are `mailto:f12345678q1@gmail.com` and in-page anchors.
- Fonts load from Google Fonts (CSS only) with system-font fallbacks.
