# Cloud Database Backup & Recovery Platform

A zero-cost, open-source database backup, recovery, and disaster recovery automation platform built using Python, FastAPI, PostgreSQL, and Docker.

The project aims to simplify database backup management, automate recovery operations, verify backup integrity, and monitor database health — without requiring paid cloud services during development.

## Project Overview

Database failures, accidental data deletion, hardware problems, and system crashes can result in significant data loss.

This project provides a platform to automate PostgreSQL database backups, manage backup files, restore databases, and monitor database health through a centralized application.

The initial implementation runs entirely on a local machine using free and open-source technologies. The architecture is designed so that cloud storage and cloud database services can be integrated later.

## Key Objectives

- Automate PostgreSQL database backups.
- Provide database restoration functionality.
- Maintain backup history and metadata.
- Verify backup file integrity.
- Monitor database connectivity and health.
- Support scheduled backup operations.
- Measure recovery performance using Recovery Point Objective (RPO) and Recovery Time Objective (RTO).
- Provide a centralized dashboard for backup and recovery operations.

## Technology Stack

| Component | Technology |
|---|---|
| Backend | Python, FastAPI |
| Database | PostgreSQL |
| Database administration | pgAdmin |
| Containerization | Docker, Docker Compose |
| Backup and recovery | pg_dump, pg_restore |
| Automation | Python, Bash |
| Frontend | React |
| Monitoring | Prometheus, Grafana |
| Version control | Git, GitHub |

All core development technologies are free and open source.

## System Architecture

```text
                React Dashboard
                       |
                       v
                 FastAPI Backend
                       |
              +--------+--------+
              |                 |
              v                 v
        PostgreSQL        Backup Manager
                                |
                         +------+------+
                         |             |
                         v             v
                    pg_dump       pg_restore
                         |             |
                         v             v
                    Local Backup Storage
                         |
                         v
                  Integrity Verification
```

## Core Modules

### 1. Database Management
- Connect to PostgreSQL.
- Check database connectivity.
- Monitor basic database health.
- Retrieve database information.

### 2. Automated Backup Management
- Create PostgreSQL backups.
- Generate timestamped backup files.
- Store backups in a local directory.
- Maintain backup metadata and history.

### 3. Database Recovery
- Select an available backup.
- Restore a database using PostgreSQL utilities.
- Protect restoration operations with confirmation checks.
- Verify whether restoration completed successfully.

### 4. Backup Integrity Verification
- Generate SHA-256 checksums.
- Detect corrupted or modified backup files.
- Validate backup availability before restoration.

### 5. Scheduling and Automation
- Schedule recurring database backups.
- Automate backup retention and cleanup.
- Record backup execution status.

### 6. Monitoring and Reporting
- Monitor database availability.
- Track backup success and failure.
- Record backup duration and file size.
- Calculate recovery-related performance metrics.

### 7. Dashboard
- Display database health.
- Show backup history.
- Display backup status.
- Provide backup and recovery controls.

## Zero-Cost Development Strategy

The initial version will run locally without paid cloud infrastructure.

- PostgreSQL runs locally through Docker.
- FastAPI provides backend services.
- Docker Compose manages application containers.
- Backup files are stored on local disk.
- GitHub is used for source-code management.
- React provides the user interface.

### Future Cloud Integration

Once the local implementation is complete, the architecture can be extended with:

- AWS S3 for remote backup storage.
- AWS EC2 for hosting.
- AWS RDS for managed PostgreSQL.
- Cloud monitoring and alerting.

These are optional future enhancements and are not required for the core project.

## Project Structure

```text
cloud-db-backup-recovery/
│
├── app/
│   ├── __init__.py
│   └── main.py
│
├── scripts/
│   ├── backup.sh
│   └── restore.sh
│
├── tests/
│   └── test_health.py
│
├── backups/
│
├── requirements.txt
├── Dockerfile
├── docker-compose.yml
├── .env.example
├── .gitignore
└── README.md
```

Additional modules and folders will be introduced as development progresses.

## Getting Started

### Prerequisites

Install the following tools:

- Python 3.11 or later
- Docker Desktop
- Git
- Visual Studio Code

### 1. Clone the Repository

```bash
git clone https://github.com/Taranjot13/cloud-db-backup-recovery.git

cd cloud-db-backup-recovery
```

### 2. Configure Environment Variables

Copy the example environment file:

```bash
cp .env.example .env
```

Configure the database credentials and connection settings in `.env`.

Use your own strong local development password. Never commit `.env` or publish database credentials.

### 3. Start the Application

```bash
docker compose up --build
```

### 4. Access the API

Open:

```text
http://localhost:8000
```

FastAPI interactive documentation:

```text
http://localhost:8000/docs
```

### 5. Stop the Application

```bash
docker compose down
```

## API Endpoints

| Method | Endpoint | Purpose |
|---|---|---|
| GET | `/` | Application information |
| GET | `/health` | Database connectivity check |

Additional backup, recovery, and monitoring endpoints will be implemented during development.

## Development Roadmap

- [x] Initial project structure
- [x] FastAPI application scaffold
- [x] PostgreSQL Docker configuration
- [x] Basic backup and restore scripts
- [ ] Test local database connectivity
- [ ] Implement automated backup management
- [ ] Implement backup history and metadata
- [ ] Implement SHA-256 integrity verification
- [ ] Implement secure database restoration
- [ ] Implement scheduled backups
- [ ] Implement recovery metrics (RPO/RTO)
- [ ] Develop React dashboard
- [ ] Add monitoring and alerting
- [ ] Add automated testing
- [ ] Explore optional AWS integration

## Security Considerations

- Keep database credentials in environment variables.
- Never commit `.env` files or secrets to GitHub.
- Restrict access to backup files.
- Require explicit confirmation before destructive restoration.
- Validate backup files before recovery.
- Use appropriate database permissions.
- Protect any future cloud storage with least-privilege IAM policies.

## Project Status

**Status:** Initial development

This repository currently contains the starter application scaffold. Features listed in the development roadmap are planned and should not be considered implemented until tested.

## License

This project is intended for educational and portfolio purposes. An open-source license can be added once selected.