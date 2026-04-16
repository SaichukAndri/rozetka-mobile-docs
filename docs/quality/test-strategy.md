# Test Strategy — Rozetka Mobile

> Вимоги беруться з [SSD.md](../architecture/SSD.md).
> Усі тест-кейси прив'язані до FR через [Traceability Matrix](traceability-matrix.md).

## 1. Рівні тестування

| Рівень | Інструменти | Покриття | Відповідальний |
|---|---|---|---|
| Unit Tests | XCTest / JUnit 5 | >= 80% | Розробник (TDD) |
| Integration Tests | MockWebServer / OHHTTPStubs | >= 60% | Розробник / QA |
| UI / E2E Tests | XCUITest / Espresso | Критичні флоу | QA-інженер |
| Manual Testing | Реальні пристрої | Регресія, UX | QA-інженер |
| Performance Tests | Xcode Instruments / Android Profiler | KPI метрики | QA / DevOps |

## 2. Пріоритети тестування

- **P0 (Блокуючий):** Оформлення замовлення, оплата, автентифікація
- **P1 (Критичний):** Пошук, кошик, відстеження замовлення, push-сповіщення
- **P2 (Важливий):** Wishlist, відгуки, профіль, фільтрація
- **P3 (Низький):** UI-деталі, анімації, dark mode, accessibility

## 3. Підходи до тестування

- Smoke-тестування при кожному релізі (TestFlight / Firebase Distribution)
- Регресійне тестування перед production-релізом (мінімум 3 дні)
- Exploratory-тестування нових функцій на реальних пристроях
- A/B testing через Firebase A/B Testing
- Тестування на слабких Android-пристроях та повільному з'єднанні (3G)
 
## 4. ?????????? ?????????? 
 
- Dev - ???????? ?????????? ?????????? 
- Staging - ????? production ??? QA 
- Production - ?????????? ????? Crashlytics 
