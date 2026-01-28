from sqlalchemy import Column, Integer, String, Date, ARRAY, JSON
from .database import Base

class Paper(Base):
    __tablename__ = "papers"

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String, index=True)
    authors = Column(JSON) # List of authors
    summary_points = Column(JSON) # List of bullet points
    published_date = Column(Date)
    source_url = Column(String)
    pdf_url = Column(String)
    citations = Column(JSON) # List of citation identifiers
    categories = Column(JSON) # List of categories
    arxiv_id = Column(String, unique=True, index=True)
