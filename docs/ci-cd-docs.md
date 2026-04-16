# Documentation CI/CD Pipeline — Rozetka Mobile

## Огляд

Документація автоматично генерується та публікується при кожному merge у гілку `main`.
Це забезпечує що сайт документації завжди актуальний і відповідає останній версії коду.

## Артефакти документації

| Артефакт | Інструмент | URL |
|---|---|---|
| Головний сайт документації | GitHub Pages | https://saichukandri.github.io/rozetka-mobile-docs/ |
| Swagger UI | GitHub Pages | https://saichukandri.github.io/rozetka-mobile-docs/swagger-ui.html |
| OpenAPI специфікація | Raw GitHub | https://raw.githubusercontent.com/SaichukAndri/rozetka-mobile-docs/main/docs/api/openapi.yaml |

## Тригери генерації

| Тригер | Дія |
|---|---|
| Push у `feature/*` гілку | Валідація OpenAPI специфікації |
| Merge у `main` | Повна публікація документації на GitHub Pages |
| Зміна `docs/api/openapi.yaml` | Автоматичне оновлення Swagger UI |

## Кроки Pipeline

```yaml
name: Documentation CI/CD

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  validate:
    name: Validate Documentation
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Validate OpenAPI specification
        uses: char0n/swagger-editor-validate@v1
        with:
          definition-file: docs/api/openapi.yaml

      - name: Check Markdown links
        uses: gaurav-nelson/github-action-markdown-link-check@v1

  publish:
    name: Publish to GitHub Pages
    runs-on: ubuntu-latest
    needs: validate
    if: github.ref == 'refs/heads/main'
    steps:
      - uses: actions/checkout@v3

      - name: Setup Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.11'

      - name: Install MkDocs
        run: pip install mkdocs mkdocs-material

      - name: Build documentation site
        run: mkdocs build --strict

      - name: Deploy to GitHub Pages
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./site
```

## Структура URL після публікації

```
https://saichukandri.github.io/rozetka-mobile-docs/
├── index.html                  # README (головна)
├── swagger-ui.html             # Swagger UI
├── docs/
│   ├── architecture/
│   │   ├── SSD/                # System Specification
│   │   ├── SDD/                # Software Design
│   │   └── ISD/                # Infrastructure
│   ├── api/
│   │   └── openapi.yaml        # OpenAPI специфікація
│   └── quality/
│       ├── test-strategy/      # Test Strategy
│       └── traceability-matrix/ # Traceability Matrix
```

## Версійність документації

| Тип зміни | Зміна версії | Приклад |
|---|---|---|
| Breaking API change | MAJOR (X.0.0) | v1.5.0 → v2.0.0 |
| Нова функціональність | MINOR (x.Y.0) | v2.0.0 → v2.1.0 |
| Виправлення / уточнення | PATCH (x.y.Z) | v2.1.0 → v2.1.1 |

Версія документації завжди відповідає версії продукту (SemVer).
