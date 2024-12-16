import os


class Config:
    SECRET_KEY = os.environ.get("SECRET_KEY", "your_secret_key")
    # usaremos SQLite en un archivo local
    SQLALCHEMY_DATABASE_URI = os.environ.get(
        "DATABASE_URI", "sqlite:///dev_database.db"
    )
    SQLALCHEMY_TRACK_MODIFICATIONS = False


class DevelopmentConfig(Config):
    DEBUG = True


class ProductionConfig(Config):
    DEBUG = False


class TestingConfig(Config):
    TESTING = True
    # database temporal para tests. Solo hara falta borrar el coverage (opcional) para tener todo optimizado (https://stackoverflow.com/questions/32833145/advantages-of-an-in-memory-database-in-sqlite)
    SQLALCHEMY_DATABASE_URI = "sqlite://"


config_dict = {
    "development": DevelopmentConfig,
    "production": ProductionConfig,
    "testing": TestingConfig,
}
