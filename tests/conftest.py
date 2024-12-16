import pytest
from app import create_app, db


@pytest.fixture(scope="session")
def test_app():
    app = create_app("testing")
    with app.app_context():
        yield app


@pytest.fixture(scope="session")
def test_client(test_app):
    return test_app.test_client()


@pytest.fixture(scope="session")
def init_database(test_app):
    with test_app.app_context():
        db.create_all()
        yield db
        db.drop_all()
