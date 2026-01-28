# Footnote

## Project Overview

Footnote is a citation-first, distraction-free research reader for astronomy, space technology, and aerospace engineering. It curates papers from trusted sources such as arXiv and space agency archives, presenting them as concise, scrollable summaries with explicit citations and direct links to original publications. Designed for focused reading rather than engagement metrics, Footnote helps learners and researchers stay connected to scientific literature without noise or hype.

## Core Features
- **Scrollable Feed**: Concise research summaries with explicit citations.
- **Source Access**: Direct links to original PDFs and source materials.
- **Focused UI**: Dark-mode, typography-centric design without ads or algorithmic manipulation.


## Design Principles
- **Citation First**: No claims without sources.
- **Distraction Free**: No ads, notifications, or engagement-baiting algorithms.
- **Chronological Order**: Content is ordered by time or topic, not virality.

## Architecture
- **Frontend**: Flutter (Android, Linux desktop)
- **Backend**: Python + FastAPI
- **Data Sources**: arXiv (extensible to NASA/ESA)
- **Summarization**: LLM-based processing

## Project Status
The backend API is functional and serving data. The frontend is under active development and testing on Linux desktop, with Android deployment planned following UI/UX validation.

---
For technical setup and installation instructions, please refer to the [Developer Guide](DEVELOPER.md).
