import json

def test_insert_data(test_client, init_database):
    payload = {"name": "NewData"}
    response = test_client.post("/data",
                                data=json.dumps(payload),
                                content_type="application/json")
    assert response.status_code == 200
    assert b"Data inserted successfully" in response.data
