import pytest
from app import app

@pytest.fixture
def client():
    app.config["TESTING"] = True
    with app.test_client() as client:
        yield client

def test_hello_returns_200(client):
    response = client.get("/")
    assert response.status_code == 200

def test_hello_contains_text(client):
    response = client.get("/")
    assert b"Hello" in response.data

def test_health_endpoint(client):
    response = client.get("/health")
    assert response.status_code == 200
    data = response.get_json()
    assert data["status"] == "ok"

def test_health_endpoint_returns_json(client):
    response = client.get("/health")
    assert response.content_type == "application/json"

def test_unknown_endpoint_returns_404(client):
    response = client.get("/unknown")
    assert response.status_code == 404

def test_unknown_endpoint_returns_expected_message(client):
    response = client.get("/unknown")
    assert b"Not Found" in response.data
    
def test_hello_endpoint_returns_expected_message(client):
    response = client.get("/")
    assert response.data == b"Hello, World! \xf0\x9f\x9a\x80 TechFlow CI/CD Pipeline is live."