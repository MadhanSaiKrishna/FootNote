from apscheduler.schedulers.background import BackgroundScheduler
from sqlalchemy.orm import Session
from ..database import SessionLocal
from ..models import Paper
from .arxiv_fetcher import fetch_arxiv_papers
from .gemini_summarizer import generate_summary
import datetime

def update_papers():
    print(f"Fetching papers at {datetime.datetime.now()}...")
    db: Session = SessionLocal()
    try:
        raw_papers = fetch_arxiv_papers(max_results=5) # Keeping it low for demo
        for p_data in raw_papers:
            # Check if exists
            exists = db.query(Paper).filter(Paper.arxiv_id == p_data['arxiv_id']).first()
            if not exists:
                print(f"Processing new paper: {p_data['title']}")
                # Generate summary
                summary = generate_summary(p_data['summary'], p_data['title'])
                
                new_paper = Paper(
                    title=p_data['title'],
                    authors=p_data['authors'],
                    summary_points=summary,
                    published_date=p_data['published_date'],
                    source_url=p_data['source_url'],
                    pdf_url=p_data['pdf_url'],
                    citations=[], # Future: extract citations
                    categories=p_data['categories'],
                    arxiv_id=p_data['arxiv_id']
                )
                db.add(new_paper)
                db.commit()
    except Exception as e:
        print(f"Error in update_papers: {e}")
    finally:
        db.close()

def start_scheduler():
    scheduler = BackgroundScheduler()
    scheduler.add_job(update_papers, 'interval', minutes=60) # Run every hour
    scheduler.start()
    # Run once immediately for demo
    # update_papers() 
