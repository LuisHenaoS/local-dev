def test_create_data(init_database):
    from app.models import Data
    db = init_database

    data_item = Data(name="TestInSQLite")
    db.session.add(data_item)
    db.session.commit()

    assert data_item.id is not None
    found = db.session.get(Data, data_item.id)
    assert found is not None
    assert found.name == "TestInSQLite"
