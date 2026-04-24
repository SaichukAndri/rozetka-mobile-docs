import os

# Відновлюємо README.md
readme = """# Rozetka Mobile — Documentation Hub

Мобільний застосунок Rozetka для iOS та Android.

## Навігація по документації

### Архітектура
- [System Specification (SSD)](docs/architecture/SSD.md) — вимоги до системи
- [Software Design (SDD)](docs/architecture/SDD.md) — архітектура та компоненти
- [Infrastructure (ISD)](docs/architecture/ISD.md) — хмарна інфраструктура, CI/CD

### API
- [OpenAPI Специфікація](docs/api/openapi.yaml) — контракт REST API
- [Swagger UI](https://saichukandri.github.io/rozetka-mobile-docs/swagger-ui.html) — інтерактивна документація API

### Якість
- [Test Strategy](docs/quality/test-strategy.md) — стратегія тестування
- [Traceability Matrix](docs/quality/traceability-matrix.md) — матриця вимог/тестів

### Розробникам
- [Onboarding Guide](docs/developer/onboarding.md) — старт для нових розробників
- [Contribution Guide](docs/developer/contribution-guide.md) — правила PR та review

## Версія документації

Поточна версія: **v2.1.1** (відповідає release/2.1.1 застосунку)
"""

with open('README.md', 'w', encoding='utf-8') as f:
    f.write(readme)

print("README.md відновлено!")
print("\nТепер введи в cmd:")
print("  git add .")
print('  git commit -m "fix: відновлено README.md, видалено зайві файли"')
print("  git push origin main")
