import sys
import os

# Add the project root to the python path
sys.path.append(os.getcwd())

from backend.app.services.scheduler import update_papers
from backend.app.database import SessionLocal
from backend.app.models import Paper

print("Triggering manual fetch...")
update_papers()

db = SessionLocal()
count = db.query(Paper).count()
print(f"Total papers in DB: {count}")
papers = db.query(Paper).all()
for p in papers:
    print(f"- {p.title} (arXiv: {p.arxiv_id})")
db.close()
