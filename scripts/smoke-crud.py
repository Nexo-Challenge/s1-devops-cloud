#!/usr/bin/env python3
"""Teste descartável: somente executar no modo demo H2."""
import json
import os
import uuid
import urllib.request
import urllib.error

base = os.environ.get("BASE_URL", "http://127.0.0.1:8080").rstrip("/")
def request(method, path, body=None):
    data = None if body is None else json.dumps(body).encode()
    req = urllib.request.Request(base + path, data=data, method=method,
                                 headers={"Content-Type": "application/json"})
    try:
        with urllib.request.urlopen(req, timeout=10) as response:
            content = response.read()
            return response.status, json.loads(content) if content else None
    except urllib.error.HTTPError as error:
        return error.code, None

status, areas = request("GET", "/api/areas")
assert status == 200 and areas["content"], "Demo deve ter área fictícia"
area_id = areas["content"][0]["id"]
payload = {"areaAplicacaoId": area_id, "titulo": "Teste DevOps " + str(uuid.uuid4()),
           "resumo": "Registro sintético temporário.", "descricao": "Validação de infraestrutura."}
resource = None
try:
    status, created = request("POST", "/api/aplicacoes", payload)
    assert status == 201, status
    resource = "/api/aplicacoes/" + str(created["id"])
    assert request("GET", resource)[0] == 200
    payload["resumo"] = "Registro sintético atualizado."
    assert request("PUT", resource, payload)[0] == 200
    assert request("POST", "/api/aplicacoes", {})[0] == 400
    assert request("DELETE", resource)[0] == 204
    assert request("GET", resource)[0] == 404
    resource = None
    print("CRUD demo: POST 201, GET 200, PUT 200, validação 400, DELETE 204, ausente 404")
finally:
    if resource:
        request("DELETE", resource)
