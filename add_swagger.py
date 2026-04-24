with open('README.md', 'r', encoding='utf-8') as f:
    content = f.read()

old = '- [OpenAPI Специфікація](docs/api/openapi.yaml) — контракт REST API'
new = '''- [OpenAPI Специфікація](docs/api/openapi.yaml) — контракт REST API
- [Swagger UI](https://saichukandri.github.io/rozetka-mobile-docs/swagger-ui.html) — інтерактивна документація API'''

content = content.replace(old, new)

with open('README.md', 'w', encoding='utf-8') as f:
    f.write(content)

print('Готово! Посилання на Swagger UI додано у README.md')
