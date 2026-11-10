import os

import psycopg
from fastapi import FastAPI, HTTPException

app = FastAPI(
    title="Cloud Database Backup & Recovery Platform",
    description="A cloud-ready PostgreSQL backup and recovery service.",
    version="0.1.0",
)


@app.get("/")
def root():
    return {
        "name": "Cloud Database Backup & Recovery Platform",
        "version": "0.1.0",
        "status": "development",
    }


@app.get("/health")
def health():
    database_url = os.getenv(
        "DATABASE_URL",
        "postgresql://backup_user:change_me@localhost:5432/backup_platform",
    )
    try:
        with psycopg.connect(database_url, connect_timeout=3) as connection:
            with connection.cursor() as cursor:
                cursor.execute("SELECT 1")
                cursor.fetchone()
        return {"status": "healthy", "database": "connected"}
    except Exception as exc:
        raise HTTPException(
            status_code=503,
            detail={"status": "unhealthy", "database": "unavailable"},
        ) from exc
