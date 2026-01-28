import feedparser
import urllib.request
import urllib.parse
from datetime import datetime
from typing import List, Dict

# Categories: astro-ph (Astrophysics), physics.space-ph (Space Physics), eess.SP (Signal Processing), cs.RO (Robotics)
ARXIV_API_URL = "http://export.arxiv.org/api/query?"
SEARCH_CATEGORIES = ["cat:astro-ph", "cat:physics.space-ph", "cat:eess.SP", "cat:cs.RO"]

def fetch_arxiv_papers(max_results: int = 10) -> List[Dict]:
    """
    Fetches latest papers from arXiv for defined categories.
    """
    search_query = " OR ".join(SEARCH_CATEGORIES)
    params = {
        "search_query": search_query,
        "start": 0,
        "max_results": max_results,
        "sortBy": "submittedDate",
        "sortOrder": "descending"
    }
    
    query_string = urllib.parse.urlencode(params)
    url = ARXIV_API_URL + query_string
    
    response = urllib.request.urlopen(url).read()
    feed = feedparser.parse(response)
    
    papers = []
    for entry in feed.entries:
        paper = {
            "title": entry.title.replace("\n", " "),
            "authors": [author.name for author in entry.authors],
            "summary": entry.summary,
            "published_date": datetime.strptime(entry.published, "%Y-%m-%dT%H:%M:%SZ").date(),
            "source_url": entry.id,
            "pdf_url": next((link.href for link in entry.links if link.type == 'application/pdf'), None),
            "arxiv_id": entry.id.split('/')[-1],
            "categories": [tag.term for tag in entry.tags]
        }
        papers.append(paper)
        
    return papers
