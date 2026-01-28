import sys
import os
sys.path.append(os.getcwd())

from backend.app.services.arxiv_fetcher import fetch_arxiv_papers

print("Fetching from arXiv...")
papers = fetch_arxiv_papers(max_results=5)
print(f"Fetched {len(papers)} papers.")
for p in papers:
    print(f"- {p['title']}")
