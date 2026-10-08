# GitHub Pages Website

This folder contains the student-facing static website for **Experimental Analysis of Public Policies**.

## Structure

- `index.html`: course overview, learning objectives, and session sequence.
- `sessions.html`: session-by-session guide with links to slides, homework, theory sheets, and R scripts.
- `homework.html`: rendered homework viewer with Markdown and R downloads.
- `materials.html`: student-facing download hub for slides, homework, theory sheets, and R scripts.
- `references.html`: references and reading cues found in the course materials.
- `practical.html`: course format, assessment, homework, R requirements, and instructor contact.
- `assets/`: stylesheet and visual course map.
- `downloads/`: student-safe copies of public materials.

## GitHub Pages

Configure GitHub Pages to serve from the `/docs` folder on the relevant branch. The site is plain HTML/CSS and uses `.nojekyll`, so there is no build step.

## Public Boundary

Only student-facing files are copied into `downloads/`. Do not copy solution keys, QCM answer banks, internal review reports, agent prompts, or source `.tex` files with presenter notes into this folder.

When source course materials change, update the corresponding copied files in `downloads/` and rerun a link check before sharing the site.
