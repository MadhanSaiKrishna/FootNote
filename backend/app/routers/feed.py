from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List
from .. import models, database
from pydantic import BaseModel
from datetime import date

router = APIRouter()

class PaperSchema(BaseModel):
    id: int
    title: str
    summary_points: List[str]
    authors: List[str]
    published_date: date
    source_url: str
    pdf_url: str | None
    categories: List[str]

    class Config:
        from_attributes = True

@router.get("/feed", response_model=List[PaperSchema])
def get_feed(skip: int = 0, limit: int = 10, db: Session = Depends(database.get_db)):
    papers = db.query(models.Paper).order_by(models.Paper.published_date.desc()).offset(skip).limit(limit).all()
    return papers
