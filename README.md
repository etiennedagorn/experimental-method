# GitHub Pages Website

This folder contains the student-facing static website for **Experimental Analysis of Public Policies**.

## Structure

- `index.html`: course overview, current teaching decks, syllabus, and assessment.
- `sessions.html`: eight-topic guide, combined decks, reference slides, readings, and selected practice routes.
- `homework.html`: rendered homework viewer with Markdown and R downloads.
- `assets/`: stylesheet and visual course map.
- `downloads/`: student-safe copies of public materials.

## GitHub Pages

The course checkout keeps the site in `/docs`. The publication script copies only that directory to a separate public repository, whose `main` branch root is served by GitHub Pages. The site is plain HTML/CSS/JavaScript and uses `.nojekyll`, so there is no build step.

## Public Boundary

Only student-facing files are copied into `downloads/`. Do not copy solution keys, QCM answer banks, internal review reports, agent prompts, or source `.tex` files with presenter notes into this folder.

## Updating

From the course checkout, run `bash scripts/publish_student_site.sh --sync-only` to copy current downloads and check local links and homework routes. Use `python3 scripts/sync_student_downloads.py --check` for a read-only freshness check.

The explicit PDF mapping in `scripts/sync_student_downloads.py` includes the combined teaching decks, revised individual decks in `lectures/revised_pdfs/`, and two earlier reference decks needed for the selection/RCT topics. It never copies an entire lecture archive or build directory. Homework, R starters and syllabuses are copied from their source directories.

To publish, run `bash scripts/publish_student_site.sh`. It uses a separate checkout, preserves the public repository's history and pushes normally. A dirty checkout or divergent history stops publication rather than overwriting work.
