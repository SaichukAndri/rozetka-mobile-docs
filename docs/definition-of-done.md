# Definition of Done — Documentation

> Цей документ визначає критерії готовності змін з точки зору документації.
> Жодна задача не вважається завершеною поки не виконані відповідні документаційні вимоги.

## Таблиця DoD за типом змін

| Тип зміни | Обов'язкові дії | Автоматична перевірка |
|---|---|---|
| Додано новий API ендпоінт | Оновити `docs/api/openapi.yaml` | OpenAPI validation у CI |
| Змінено request/response структуру | Оновити схеми в `openapi.yaml`, оновити Swagger UI | OpenAPI validation у CI |
| Додано нову функціональну вимогу | Додати FR-xx у `docs/architecture/SSD.md` | Markdown lint |
| Змінено існуючу вимогу | Оновити SSD.md + оновити Traceability Matrix | Markdown link check |
| Додано новий UI компонент | Додати Story у `docs/storybook.md` | Storybook build |
| Змінено архітектурне рішення | Оновити `docs/architecture/SDD.md` з датою та причиною | — |
| Зміна інфраструктури | Оновити `docs/architecture/ISD.md` | — |
| Breaking API change | Нова мажорна версія документації, оновити CHANGELOG.md | Version tag у CI |
| Будь-який реліз | Додати розділ у `CHANGELOG.md` | — |

## Перевірювані критерії готовності

### Зміна API
- [ ] `openapi.yaml` оновлено до реалізації (API-first підхід)
- [ ] Swagger UI відображає нові ендпоінти коректно
- [ ] Версія в `info.version` збільшена відповідно до типу змін
- [ ] CI/CD валідація OpenAPI проходить без помилок

### Нова функціональність
- [ ] Вимога додана в `SSD.md` з унікальним ідентифікатором FR-xx
- [ ] Тест-кейси додані в `traceability-matrix.md` з посиланням на FR-xx
- [ ] README.md оновлено якщо змінилась структура документації

### UI компонент
- [ ] Story додана в `docs/storybook.md`
- [ ] Описані мінімум 2 стани: базовий та альтернативний (disabled/loading/error)
- [ ] Storybook збірка проходить без помилок

### Будь-яка зміна
- [ ] Зміни внесені через Pull Request
- [ ] PR пройшов Code Review
- [ ] CI/CD pipeline зелений
- [ ] `CHANGELOG.md` оновлено при релізі

## Приклад перевірки DoD на практиці

Розробник додає новий ендпоінт `GET /api/v2/products/{id}/reviews`:

1. Спочатку оновлює `openapi.yaml` — додає новий path (API-first)
2. CI автоматично валідує специфікацію
3. Реалізує ендпоінт у коді
4. Додає тест-кейс TC-25 у `traceability-matrix.md`
5. Відкриває PR з усіма змінами разом
6. Після merge — Swagger UI автоматично оновлюється на GitHub Pages
