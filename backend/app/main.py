from fastapi import FastAPI, Depends, HTTPException
from sqlalchemy.orm import Session
from . import models, database

models.Base.metadata.create_all(bind=database.engine)

app = FastAPI(title="Footnote API")

from .routers import feed
from .services import scheduler

app.include_router(feed.router)

@app.on_event("startup")
def startup_event():
    scheduler.start_scheduler()

@app.get("/")
def read_root():
    return {"message": "Welcome to Footnote API", "status": "running"}
