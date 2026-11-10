# Cloud Database Backup & Recovery Platform

A cloud-ready platform for automating PostgreSQL backups, tracking backup history, and safely restoring databases. Development starts with a local Docker-based MVP, then expands to AWS S3 storage and recovery verification.

> **Status:** Initial scaffold / MVP in progress. Items in the roadmap are planned until implemented and tested.

## Objectives

- Run PostgreSQL locally with Docker Compose.
- Provide a FastAPI health endpoint.
- Create timestamped PostgreSQL backups with `pg_dump`.
- Restore a backup with an explicit safety confirmation.
- Keep credentials in environment variables, never in source control.
- Extend the system with S3 storage, restore verification, monitoring, and a dashboard.

## Architecture

```text
Operator / Dashboard
        |
        v
   FastAPI service
        |
        +------ PostgreSQL
        |
        v
 Backup automation
        |
        +------ Local backup directory
        |
        +------ AWS S3 (planned)
```

## Technology stack

| Area | Technology |
|---|---|
| API | Python, FastAPI |
| Database | PostgreSQL |
| Backup / restore | `pg_dump`, `pg_restore` |
| Containers | Docker, Docker Compose |
| Cloud storage (planned) | Amazon S3 |
| Testing | pytest |

## Repository structure

```text
cloud-db-backup-recovery/
├── app/
│   ├── __init__.py
│   └── main.py
├── scripts/
│   ├── backup.sh
│   └── restore.sh
├── tests/
│   └── test_health.py
├── .env.example
├── .gitignore
├── docker-compose.yml
├── Dockerfile
└── requirements.txt
```

## Run locally

### Prerequisites

- Docker Desktop with Docker Compose
- Git
- Python 3.11+ (only needed to run tests locally)

### 1. Clone

```bash
git clone https://github.com/<your-github-username>/cloud-db-backup-recovery.git
cd cloud-db-backup-recovery
```

### 2. Configure

```bash
cp .env.example .env
```

Change the local development password in `.env`. Never commit `.env` or real credentials.

### 3. Start

```bash
docker compose up --build
```

Endpoints:

- API: http://localhost:8000
- Health: http://localhost:8000/health
- Interactive API docs: http://localhost:8000/docs
- PostgreSQL: `localhost:5432`

### 4. Create a backup

Install PostgreSQL client tools and make sure the database is reachable. Set `PGPASSWORD` in your shell, then run:

```bash
chmod +x scripts/*.sh
./scripts/backup.sh
```

Backups are written to `backups/`, which is excluded from Git because database dumps can contain sensitive data.

### 5. Restore a backup

**Warning:** Restore can replace objects and data in the target database. Test with a disposable database first.

```bash
CONFIRM_RESTORE=YES ./scripts/restore.sh backups/<backup-file>.dump
```

The explicit confirmation prevents accidental execution.

## API endpoints

| Method | Endpoint | Purpose |
|---|---|---|
| GET | `/` | Basic service information |
| GET | `/health` | API and PostgreSQL connectivity check |

## Roadmap

- [x] Initial FastAPI and Docker Compose scaffold
- [x] PostgreSQL health-check endpoint
- [x] Local `pg_dump` backup script
- [x] Guarded `pg_restore` script
- [ ] Backup metadata and history API
- [ ] Scheduled backups
- [ ] AWS S3 upload/download with least-privilege IAM
- [ ] Backup checksum and restore verification
- [ ] PostgreSQL point-in-time recovery using WAL archiving
- [ ] RPO/RTO reporting and alerting
- [ ] React dashboard
- [ ] CI workflow and deployment guide

## Security notes

- Use a dedicated PostgreSQL role with only required permissions.
- Do not expose PostgreSQL publicly.
- Use private S3 buckets, encryption, and least-privilege IAM when S3 support is implemented.
- Test restores against a separate database before production use.
- Treat backups as sensitive data.
- This academic starter is not production-ready.

## Tests

```bash
pip install -r requirements.txt
pytest
```

## Author

**Taranjot Singh** — Computer Science & Engineering

## License

No license has been selected yet. Add one before accepting external contributions.
