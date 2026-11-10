from fastapi.testclient import TestClient

from app.main import app

client = TestClient(app)


def test_root_returns_project_information():
    response = client.get("/")
    assert response.status_code == 200
    assert response.json()["name"] == "Cloud Database Backup & Recovery Platform"


def test_health_returns_service_unavailable_when_database_is_unreachable(monkeypatch):
    monkeypatch.setenv(
        "DATABASE_URL",
        "postgresql://invalid:invalid@127.0.0.1:1/does_not_exist",
    )
    response = client.get("/health")
    assert response.status_code == 503
