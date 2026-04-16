@echo off
chcp 65001 >nul
echo === Створення структури документації Rozetka Mobile ===

:: Створення папок
mkdir docs\architecture 2>nul
mkdir docs\quality 2>nul
mkdir docs\api 2>nul
mkdir docs\developer 2>nul

:: ============================================================
:: README.md
:: ============================================================
(
echo # Rozetka Mobile — Documentation Hub
echo.
echo Мобільний застосунок Rozetka для iOS та Android.
echo.
echo ## Навігація по документації
echo.
echo ### Архітектура
echo - [System Specification ^(SSD^)](docs/architecture/SSD.md^) — вимоги до системи
echo - [Software Design ^(SDD^)](docs/architecture/SDD.md^) — архітектура та компоненти
echo - [Infrastructure ^(ISD^)](docs/architecture/ISD.md^) — хмарна інфраструктура, CI/CD
echo.
echo ### API
echo - [OpenAPI Специфікація](docs/api/openapi.yaml^) — контракт REST API
echo.
echo ### Якість
echo - [Test Strategy](docs/quality/test-strategy.md^) — стратегія тестування
echo - [Traceability Matrix](docs/quality/traceability-matrix.md^) — матриця вимог/тестів
echo.
echo ### Розробникам
echo - [Onboarding Guide](docs/developer/onboarding.md^) — старт для нових розробників
echo - [Contribution Guide](docs/developer/contribution-guide.md^) — правила PR та review
echo.
echo ## Версія документації
echo.
echo Поточна версія: **v2.1.0** ^(відповідає release/2.1.0 застосунку^)
) > README.md

:: ============================================================
:: CHANGELOG.md
:: ============================================================
(
echo # Changelog — Rozetka Mobile Documentation
echo.
echo ## [v2.1.0] — 2026-03-15
echo.
echo ### Додано
echo - SDD: описано новий модуль AR-preview товарів ^(FR-10^)
echo - openapi.yaml: додано ендпоінт GET /api/v2/products/{id}/ar-model
echo.
echo ### Змінено
echo - SSD: уточнено вимогу FR-01 ^(голосовий пошук тепер P0^)
echo - traceability-matrix.md: додано TC-23, TC-24 для FR-10
echo.
echo ## [v2.0.0] — 2026-01-20
echo.
echo ### Breaking Changes
echo - openapi.yaml: ендпоінт /api/v1/cart замінено на /api/v2/cart
echo - Оновлено SDD ^(розділ 4.3^) та Onboarding Guide
) > CHANGELOG.md

:: ============================================================
:: mkdocs.yml
:: ============================================================
(
echo site_name: Rozetka Mobile Documentation
echo site_url: https://rozetka-team.github.io/rozetka-mobile-docs/
echo site_description: Документація мобільного застосунку Rozetka
echo.
echo theme:
echo   name: material
echo   language: uk
echo   palette:
echo     - scheme: default
echo       primary: indigo
echo       accent: orange
echo   features:
echo     - navigation.tabs
echo     - navigation.sections
echo     - search.suggest
echo     - content.code.copy
echo.
echo nav:
echo   - Головна: README.md
echo   - Архітектура:
echo     - 'Вимоги ^(SSD^)': docs/architecture/SSD.md
echo     - 'Дизайн ^(SDD^)': docs/architecture/SDD.md
echo     - 'Інфраструктура ^(ISD^)': docs/architecture/ISD.md
echo   - API:
echo     - 'OpenAPI Специфікація': docs/api/openapi.yaml
echo   - Якість:
echo     - 'Test Strategy': docs/quality/test-strategy.md
echo     - 'Traceability Matrix': docs/quality/traceability-matrix.md
echo   - Розробникам:
echo     - 'Onboarding': docs/developer/onboarding.md
echo     - 'Contribution Guide': docs/developer/contribution-guide.md
echo.
echo plugins:
echo   - search
echo   - git-revision-date-localized:
echo       enable_creation_date: true
echo.
echo markdown_extensions:
echo   - tables
echo   - admonition
echo   - pymdownx.highlight
echo   - pymdownx.superfences
) > mkdocs.yml

:: ============================================================
:: docs/architecture/SSD.md
:: ============================================================
(
echo # System Specification Document — Rozetka Mobile
echo.
echo ^> Це джерело істини ^(SSoT^) для всіх функціональних вимог.
echo ^> Test Strategy та Traceability Matrix посилаються на ідентифікатори FR з цього документа.
echo.
echo ## 1. Призначення системи
echo.
echo Rozetka Mobile забезпечує мобільний доступ до українського маркетплейсу Rozetka для кінцевих споживачів. Застосунок дозволяє здійснювати повний цикл купівлі — від пошуку товару до отримання замовлення — безпосередньо зі смартфона.
echo.
echo ## 2. Межі системи
echo.
echo **Охоплює:**
echo - Мобільний клієнт ^(iOS ^>= 15, Android ^>= 9^)
echo - Взаємодію з Rozetka REST API
echo - Інтеграцію з платіжними шлюзами та службами доставки
echo - Push-сповіщення через FCM ^(Android^) та APNs ^(iOS^)
echo.
echo **НЕ охоплює:**
echo - Серверну логіку бекенду та адміністративну панель
echo - Веб-версію Rozetka.ua
echo - Внутрішні системи складського обліку
echo.
echo ## 3. Функціональні вимоги
echo.
echo ^| ID ^| Функція ^| Опис ^| Пріоритет ^|
echo ^|---^|---^|---^|---^|
echo ^| FR-01 ^| Пошук товарів ^| Пошук за назвою, штрихкодом, голосом; автодоповнення ^| P0 ^|
echo ^| FR-02 ^| Фільтрація каталогу ^| Фільтрація за ціною, брендом, рейтингом, наявністю ^| P2 ^|
echo ^| FR-03 ^| Картка товару ^| Перегляд фото, характеристик, відгуків, порівняння ^| P2 ^|
echo ^| FR-04 ^| Кошик ^| Додавання/видалення товарів, зміна кількості, розрахунок ^| P1 ^|
echo ^| FR-05 ^| Оформлення замовлення ^| Вибір доставки, оплати, підтвердження ^| P0 ^|
echo ^| FR-06 ^| Відстеження замовлення ^| Статус замовлення, номер ТТН, push-сповіщення ^| P1 ^|
echo ^| FR-07 ^| Автентифікація ^| Реєстрація, логін, OAuth ^(Google, Apple^), відновлення паролю ^| P0 ^|
echo ^| FR-08 ^| Wishlist ^| Список бажань, сповіщення про зміну ціни ^| P2 ^|
echo ^| FR-09 ^| Відгуки ^| Читання та написання відгуків після покупки ^| P2 ^|
echo.
echo ## 4. Нефункціональні вимоги
echo.
echo ^| Категорія ^| Вимога ^|
echo ^|---^|---^|
echo ^| Продуктивність ^| Завантаження головного екрану до 2 секунд ^(4G^) ^|
echo ^| Продуктивність ^| Результати пошуку — до 1.5 секунди ^|
echo ^| Доступність ^| SLA серверного API — не менше 99.9%% ^|
echo ^| Безпека ^| TLS 1.3, certificate pinning, Keychain/EncryptedSharedPreferences ^|
echo ^| Безпека ^| Підтримка Face ID / Fingerprint ^|
echo ^| Сумісність ^| iOS ^>= 15 ^(iPhone 8+^), Android ^>= 9 ^(API 28+^) ^|
echo ^| Розмір ^| Не більше 100 MB після встановлення ^|
) > docs\architecture\SSD.md

:: ============================================================
:: docs/architecture/SDD.md
:: ============================================================
(
echo # Software Design Document — Rozetka Mobile
echo.
echo ^> Посилання на вимоги: [SSD.md](SSD.md^)
echo ^> Посилання на інфраструктуру: [ISD.md](ISD.md^)
echo.
echo ## 1. Загальна архітектура
echo.
echo Застосунок побудований за патерном **MVVM + Clean Architecture**. Платформи iOS та Android мають окремі нативні кодові бази зі спільними модулями через **Kotlin Multiplatform Mobile ^(KMM^)**.
echo.
echo **Архітектурні шари:**
echo - **Presentation Layer** — SwiftUI ^(iOS^) / Jetpack Compose ^(Android^), ViewModel
echo - **Domain Layer** — Use Cases, Repository Interfaces, Domain Models ^(KMM^)
echo - **Data Layer** — API-клієнти, локальна БД, Repository implementations ^(KMM^)
echo - **Infrastructure** — DI ^(Hilt/Koin^), аналітика, crash-репортинг
echo.
echo ## 2. Основні компоненти
echo.
echo ^| Компонент ^| Технологія ^| Відповідальність ^|
echo ^|---^|---^|---^|
echo ^| Search Module ^| Algolia SDK + REST ^| Пошук, автодоповнення, голосовий пошук ^|
echo ^| Catalog Module ^| REST API + Room/CoreData ^| Каталог, фільтрація, кешування ^|
echo ^| Cart Module ^| Local DB + REST ^| Кошик, синхронізація з сервером ^|
echo ^| Checkout Module ^| REST API ^| Оформлення замовлення, доставка/оплата ^|
echo ^| Payment Module ^| LiqPay SDK, Apple/Google Pay ^| Обробка платежів, токенізація ^|
echo ^| Auth Module ^| OAuth 2.0 / JWT ^| Автентифікація, токени, biometrics ^|
echo ^| Notification Module ^| FCM / APNs ^| Push-сповіщення, in-app нотифікації ^|
echo ^| Analytics Module ^| Firebase Analytics ^| Поведінка користувача, конверсії ^|
echo ^| Image Module ^| Glide / Kingfisher ^| Завантаження та кешування зображень ^|
echo.
echo ## 3. API-ендпоінти
echo.
echo Усі модулі взаємодіють через єдиний REST API Gateway. Формат — JSON. Автентифікація — Bearer JWT ^(TTL: 1 год^), refresh token — 30 днів.
echo.
echo ^| Метод ^| Ендпоінт ^| Модуль ^| Опис ^|
echo ^|---^|---^|---^|---^|
echo ^| GET ^| /api/v2/catalog/search ^| Search ^| Пошук з фільтрами ^|
echo ^| GET ^| /api/v2/products/{id} ^| Catalog ^| Картка товару ^|
echo ^| GET/POST ^| /api/v2/cart ^| Cart ^| Кошик ^|
echo ^| POST ^| /api/v2/orders ^| Checkout ^| Створення замовлення ^|
echo ^| GET ^| /api/v2/orders/{id} ^| Orders ^| Статус замовлення ^|
echo ^| POST ^| /api/v2/auth/login ^| Auth ^| Логін ^|
echo ^| POST ^| /api/v2/auth/refresh ^| Auth ^| Оновлення токена ^|
echo ^| GET/POST ^| /api/v2/wishlist ^| Wishlist ^| Список бажань ^|
echo.
echo ## 4. Локальне сховище
echo.
echo - **Room / CoreData** — кошик, wishlist, кеш каталогу
echo - **Keychain / EncryptedSharedPreferences** — токени автентифікації
echo - **In-Memory Cache** — результати пошуку ^(TTL: 5 хв^), зображення
echo - **Офлайн-режим** — остання головна сторінка та кошик без мережі
) > docs\architecture\SDD.md

:: ============================================================
:: docs/architecture/ISD.md
:: ============================================================
(
echo # Infrastructure Specification Document — Rozetka Mobile
echo.
echo ^> Посилання на компоненти: [SDD.md](SDD.md^)
echo.
echo ## 1. Середовище розгортання
echo.
echo Серверна частина розгорнута у **AWS** ^(регіон: eu-central-1, Frankfurt^). Застосунок поширюється через **App Store** ^(iOS^) та **Google Play** ^(Android^).
echo.
echo ## 2. Інфраструктурні компоненти
echo.
echo ^| Компонент ^| Технологія ^| Призначення ^|
echo ^|---^|---^|---^|
echo ^| API Gateway ^| AWS API Gateway ^| Маршрутизація, rate limiting ^|
echo ^| Load Balancer ^| AWS ALB ^| Розподіл трафіку ^|
echo ^| Контейнеризація ^| Docker + Kubernetes ^(EKS^) ^| Оркестрація, auto-scaling ^|
echo ^| База даних ^| PostgreSQL ^(RDS^) ^| Замовлення, користувачі, товари ^|
echo ^| Кеш ^| Redis ^(ElastiCache^) ^| Каталог, сесії, rate limiting ^|
echo ^| Пошук ^| Algolia ^| Повнотекстовий пошук товарів ^|
echo ^| CDN ^| AWS CloudFront ^| Зображення товарів, статичні ресурси ^|
echo ^| Push ^| FCM + APNs via AWS SNS ^| Push-нотифікації ^|
echo ^| Моніторинг ^| Datadog + CloudWatch ^| Метрики, логи, алерти ^|
echo ^| CI/CD ^| GitHub Actions + Fastlane ^| Збірка, тестування, публікація ^|
echo ^| Crash Reporting ^| Firebase Crashlytics ^| Аналіз крашів ^|
echo.
echo ## 3. CI/CD Pipeline ^(Mobile^)
echo.
echo 1. Developer робить push у feature-гілку → тригер GitHub Actions
echo 2. Запуск unit-тестів та статичного аналізу ^(SwiftLint / Detekt^)
echo 3. Збірка debug-версії → UI-тести на емуляторах
echo 4. Merge в develop → TestFlight ^(iOS^) / Firebase App Distribution ^(Android^)
echo 5. QA-тестування на реальних пристроях
echo 6. Merge в main → Fastlane публікує у App Store / Google Play ^(10%% → 50%% → 100%%^)
echo.
echo ## 4. Масштабування
echo.
echo - Kubernetes HPA: авто-додавання подів при CPU ^> 70%%
echo - PostgreSQL Read Replicas для зменшення навантаження
echo - Redis кластер, TTL кешу каталогу: 15 хвилин
echo - Blue-Green Deployment — нульовий downtime
echo - Feature Flags через LaunchDarkly
) > docs\architecture\ISD.md

:: ============================================================
:: docs/quality/test-strategy.md
:: ============================================================
(
echo # Test Strategy — Rozetka Mobile
echo.
echo ^> Вимоги беруться з [SSD.md](../architecture/SSD.md^). Усі тест-кейси прив'язані до FR через [Traceability Matrix](traceability-matrix.md^).
echo.
echo ## 1. Рівні тестування
echo.
echo ^| Рівень ^| Інструменти ^| Покриття ^| Відповідальний ^|
echo ^|---^|---^|---^|---^|
echo ^| Unit Tests ^| XCTest / JUnit 5 ^| ^>= 80%% ^| Розробник ^(TDD^) ^|
echo ^| Integration Tests ^| MockWebServer / OHHTTPStubs ^| ^>= 60%% ^| Розробник / QA ^|
echo ^| UI / E2E Tests ^| XCUITest / Espresso ^| Критичні флоу ^| QA-інженер ^|
echo ^| Manual Testing ^| Реальні пристрої ^| Регресія, UX ^| QA-інженер ^|
echo ^| Performance Tests ^| Xcode Instruments / Android Profiler ^| KPI метрики ^| QA / DevOps ^|
echo.
echo ## 2. Пріоритети тестування
echo.
echo - **P0 ^(Блокуючий^):** Оформлення замовлення, оплата, автентифікація
echo - **P1 ^(Критичний^):** Пошук, кошик, відстеження замовлення, push-сповіщення
echo - **P2 ^(Важливий^):** Wishlist, відгуки, профіль, фільтрація
echo - **P3 ^(Низький^):** UI-деталі, анімації, dark mode, accessibility
echo.
echo ## 3. Підходи до тестування
echo.
echo - Smoke-тестування при кожному релізі ^(TestFlight / Firebase Distribution^)
echo - Регресійне тестування перед production-релізом ^(мінімум 3 дні^)
echo - Exploratory-тестування нових функцій на реальних пристроях
echo - A/B testing через Firebase A/B Testing
echo - Тестування на слабких Android-пристроях та повільному з'єднанні ^(3G^)
) > docs\quality\test-strategy.md

:: ============================================================
:: docs/quality/traceability-matrix.md
:: ============================================================
(
echo # Traceability Matrix — Rozetka Mobile
echo.
echo ^> Вимоги: [SSD.md](../architecture/SSD.md^) ^| Стратегія: [test-strategy.md](test-strategy.md^)
echo.
echo ## Матриця простежуваності
echo.
echo ^| Вимога ^| Опис вимоги ^| Тест-кейси ^| Пріоритет ^| Статус ^|
echo ^|---^|---^|---^|---^|---^|
echo ^| FR-01 ^| Пошук товарів ^| TC-01, TC-02, TC-03 ^| P0 ^| Ready ^|
echo ^| FR-02 ^| Фільтрація каталогу ^| TC-04, TC-05 ^| P2 ^| Ready ^|
echo ^| FR-03 ^| Картка товару ^| TC-06, TC-07 ^| P2 ^| Ready ^|
echo ^| FR-04 ^| Кошик ^| TC-08, TC-09, TC-10 ^| P1 ^| Ready ^|
echo ^| FR-05 ^| Оформлення замовлення ^| TC-11, TC-12, TC-13 ^| P0 ^| Ready ^|
echo ^| FR-06 ^| Відстеження замовлення ^| TC-14, TC-15 ^| P1 ^| Ready ^|
echo ^| FR-07 ^| Автентифікація ^| TC-16, TC-17, TC-18 ^| P0 ^| Ready ^|
echo ^| FR-08 ^| Wishlist ^| TC-19, TC-20 ^| P2 ^| In Progress ^|
echo ^| FR-09 ^| Відгуки ^| TC-21, TC-22 ^| P2 ^| In Progress ^|
echo.
echo ## Критичні тест-кейси
echo.
echo ^| ID ^| Назва ^| Кроки ^| Очікуваний результат ^|
echo ^|---^|---^|---^|---^|
echo ^| TC-11 ^| Успішне оформлення замовлення ^| Додати товар → Кошик → Checkout → Картка → Підтвердити ^| Замовлення створено, push отримано ^|
echo ^| TC-16 ^| Логін через email ^| Ввести email + пароль → Увійти ^| Перехід до головної, токен збережено ^|
echo ^| TC-17 ^| Логін через Google OAuth ^| Google → обрати акаунт → підтвердити ^| Авторизація успішна, профіль синхронізовано ^|
echo ^| TC-01 ^| Пошук за назвою ^| Ввести 'iPhone 15' у пошук ^| Список товарів за ^< 1.5 с ^|
echo ^| TC-08 ^| Додавання до кошика ^| Картка товару → Купити ^| Товар у кошику, лічильник оновлено ^|
) > docs\quality\traceability-matrix.md

:: ============================================================
:: docs/api/openapi.yaml
:: ============================================================
(
echo openapi: 3.0.3
echo info:
echo   title: Rozetka Mobile API
echo   description: REST API для мобільного застосунку Rozetka Mobile
echo   version: 2.1.0
echo   contact:
echo     name: Rozetka Mobile Team
echo.
echo servers:
echo   - url: https://api.rozetka.com.ua
echo     description: Production
echo   - url: https://api-staging.rozetka.com.ua
echo     description: Staging
echo.
echo security:
echo   - BearerAuth: []
echo.
echo paths:
echo   /api/v2/catalog/search:
echo     get:
echo       summary: Пошук товарів
echo       tags: [Search]
echo       parameters:
echo         - name: q
echo           in: query
echo           required: true
echo           schema:
echo             type: string
echo           description: Пошуковий запит
echo         - name: page
echo           in: query
echo           schema:
echo             type: integer
echo             default: 1
echo         - name: limit
echo           in: query
echo           schema:
echo             type: integer
echo             default: 20
echo       responses:
echo         '200':
echo           description: Список товарів
echo           content:
echo             application/json:
echo               schema:
echo                 $ref: '#/components/schemas/ProductList'
echo         '400':
echo           description: Некоректний запит
echo.
echo   /api/v2/products/{id}:
echo     get:
echo       summary: Картка товару
echo       tags: [Catalog]
echo       parameters:
echo         - name: id
echo           in: path
echo           required: true
echo           schema:
echo             type: string
echo       responses:
echo         '200':
echo           description: Деталі товару
echo           content:
echo             application/json:
echo               schema:
echo                 $ref: '#/components/schemas/Product'
echo         '404':
echo           description: Товар не знайдено
echo.
echo   /api/v2/cart:
echo     get:
echo       summary: Отримати кошик
echo       tags: [Cart]
echo       responses:
echo         '200':
echo           description: Вміст кошика
echo           content:
echo             application/json:
echo               schema:
echo                 $ref: '#/components/schemas/Cart'
echo     post:
echo       summary: Додати товар до кошика
echo       tags: [Cart]
echo       requestBody:
echo         required: true
echo         content:
echo           application/json:
echo             schema:
echo               $ref: '#/components/schemas/CartItem'
echo       responses:
echo         '200':
echo           description: Кошик оновлено
echo         '400':
echo           description: Некоректні дані
echo.
echo   /api/v2/orders:
echo     post:
echo       summary: Створити замовлення
echo       tags: [Checkout]
echo       requestBody:
echo         required: true
echo         content:
echo           application/json:
echo             schema:
echo               $ref: '#/components/schemas/OrderRequest'
echo       responses:
echo         '201':
echo           description: Замовлення створено
echo           content:
echo             application/json:
echo               schema:
echo                 $ref: '#/components/schemas/Order'
echo         '400':
echo           description: Некоректні дані замовлення
echo         '402':
echo           description: Помилка оплати
echo.
echo   /api/v2/orders/{id}:
echo     get:
echo       summary: Статус замовлення
echo       tags: [Orders]
echo       parameters:
echo         - name: id
echo           in: path
echo           required: true
echo           schema:
echo             type: string
echo       responses:
echo         '200':
echo           description: Деталі замовлення
echo           content:
echo             application/json:
echo               schema:
echo                 $ref: '#/components/schemas/Order'
echo         '404':
echo           description: Замовлення не знайдено
echo.
echo   /api/v2/auth/login:
echo     post:
echo       summary: Логін користувача
echo       tags: [Auth]
echo       security: []
echo       requestBody:
echo         required: true
echo         content:
echo           application/json:
echo             schema:
echo               $ref: '#/components/schemas/LoginRequest'
echo       responses:
echo         '200':
echo           description: Успішна авторизація
echo           content:
echo             application/json:
echo               schema:
echo                 $ref: '#/components/schemas/AuthTokens'
echo         '401':
echo           description: Невірні дані
echo.
echo   /api/v2/auth/refresh:
echo     post:
echo       summary: Оновлення access token
echo       tags: [Auth]
echo       security: []
echo       requestBody:
echo         required: true
echo         content:
echo           application/json:
echo             schema:
echo               type: object
echo               properties:
echo                 refresh_token:
echo                   type: string
echo       responses:
echo         '200':
echo           description: Новий access token
echo           content:
echo             application/json:
echo               schema:
echo                 $ref: '#/components/schemas/AuthTokens'
echo         '401':
echo           description: Refresh token недійсний
echo.
echo   /api/v2/wishlist:
echo     get:
echo       summary: Список бажань
echo       tags: [Wishlist]
echo       responses:
echo         '200':
echo           description: Товари у wishlist
echo     post:
echo       summary: Додати товар до wishlist
echo       tags: [Wishlist]
echo       requestBody:
echo         required: true
echo         content:
echo           application/json:
echo             schema:
echo               type: object
echo               properties:
echo                 product_id:
echo                   type: string
echo       responses:
echo         '201':
echo           description: Додано до wishlist
echo.
echo components:
echo   securitySchemes:
echo     BearerAuth:
echo       type: http
echo       scheme: bearer
echo       bearerFormat: JWT
echo.
echo   schemas:
echo     Product:
echo       type: object
echo       properties:
echo         id:
echo           type: string
echo         name:
echo           type: string
echo         price:
echo           type: number
echo         currency:
echo           type: string
echo           example: UAH
echo         images:
echo           type: array
echo           items:
echo             type: string
echo         rating:
echo           type: number
echo           minimum: 0
echo           maximum: 5
echo         in_stock:
echo           type: boolean
echo.
echo     ProductList:
echo       type: object
echo       properties:
echo         items:
echo           type: array
echo           items:
echo             $ref: '#/components/schemas/Product'
echo         total:
echo           type: integer
echo         page:
echo           type: integer
echo.
echo     CartItem:
echo       type: object
echo       properties:
echo         product_id:
echo           type: string
echo         quantity:
echo           type: integer
echo           minimum: 1
echo.
echo     Cart:
echo       type: object
echo       properties:
echo         items:
echo           type: array
echo           items:
echo             $ref: '#/components/schemas/CartItem'
echo         total_price:
echo           type: number
echo.
echo     OrderRequest:
echo       type: object
echo       required: [delivery, payment]
echo       properties:
echo         delivery:
echo           type: object
echo           properties:
echo             method:
echo               type: string
echo               enum: [nova_poshta, ukrposhta, courier]
echo             address:
echo               type: string
echo         payment:
echo           type: object
echo           properties:
echo             method:
echo               type: string
echo               enum: [card, apple_pay, google_pay, liqpay]
echo.
echo     Order:
echo       type: object
echo       properties:
echo         id:
echo           type: string
echo         status:
echo           type: string
echo           enum: [pending, confirmed, shipped, delivered, cancelled]
echo         ttn:
echo           type: string
echo           description: Номер ТТН
echo         created_at:
echo           type: string
echo           format: date-time
echo.
echo     LoginRequest:
echo       type: object
echo       required: [email, password]
echo       properties:
echo         email:
echo           type: string
echo           format: email
echo         password:
echo           type: string
echo.
echo     AuthTokens:
echo       type: object
echo       properties:
echo         access_token:
echo           type: string
echo         refresh_token:
echo           type: string
echo         expires_in:
echo           type: integer
echo           description: Секунди до закінчення дії access token
) > docs\api\openapi.yaml

:: ============================================================
:: docs/developer/onboarding.md
:: ============================================================
(
echo # Onboarding Guide — Rozetka Mobile
echo.
echo ^> Архітектура системи: [SDD.md](../architecture/SDD.md^)
echo ^> Правила контрибуції: [contribution-guide.md](contribution-guide.md^)
echo.
echo ## 1. Вимоги до середовища
echo.
echo - **iOS:** Xcode 15+, Swift 5.9+, CocoaPods або SPM
echo - **Android:** Android Studio Hedgehog+, Kotlin 1.9+, Gradle 8+
echo - **Спільне:** Git, GitHub CLI, Python 3.10+ ^(для скриптів^)
echo.
echo ## 2. Клонування та запуск
echo.
echo ^^^```bash
echo git clone https://github.com/rozetka-team/rozetka-mobile.git
echo cd rozetka-mobile
echo ^^^```
echo.
echo **iOS:**
echo ^^^```bash
echo cd ios
echo pod install
echo open RozetkaMobile.xcworkspace
echo ^^^```
echo.
echo **Android:**
echo ^^^```bash
echo cd android
echo ./gradlew assembleDebug
echo ^^^```
echo.
echo ## 3. Конфігурація
echo.
echo Скопіюй `.env.example` у `.env` та заповни змінні:
echo - `API_BASE_URL` — URL серверного API
echo - `ALGOLIA_APP_ID` — ідентифікатор Algolia
echo - `FIREBASE_CONFIG` — шлях до google-services.json
echo.
echo ^> ⚠️ Ніколи не комітуй `.env` у репозиторій. Він вже є у `.gitignore`.
echo.
echo ## 4. Структура проекту
echo.
echo Архітектура: MVVM + Clean Architecture + KMM. Детально — у [SDD.md](../architecture/SDD.md^).
echo.
echo ## 5. Перший PR
echo.
echo 1. Створи гілку: `git checkout -b feature/твоя-задача`
echo 2. Внеси зміни та закомітуй
echo 3. Відкрий Pull Request у `develop`
echo 4. Дочекайся Code Review та CI green
echo.
echo Правила PR описані у [contribution-guide.md](contribution-guide.md^).
) > docs\developer\onboarding.md

:: ============================================================
:: docs/developer/contribution-guide.md
:: ============================================================
(
echo # Contribution Guide — Rozetka Mobile
echo.
echo ## 1. Гілки
echo.
echo - `main` — production-ready код
echo - `develop` — інтеграційна гілка
echo - `feature/*` — нові функції
echo - `fix/*` — виправлення багів
echo - `docs/*` — зміни документації
echo.
echo ## 2. Правила комітів
echo.
echo Використовуємо Conventional Commits:
echo.
echo ^^^```
echo feat: додано голосовий пошук ^(FR-01^)
echo fix: виправлено синхронізацію кошика ^(FR-04^)
echo docs: оновлено SSD — вимога FR-01 стала P0
echo ^^^```
echo.
echo ## 3. Pull Request
echo.
echo - PR відкривається лише в `develop`
echo - Обов'язковий Code Review від 1 розробника
echo - CI має бути green ^(тести, лінтер^)
echo - **Зміна функціональної вимоги → обов'язково оновити SSD.md у тому ж PR**
echo - **Зміна API → обов'язково оновити openapi.yaml**
echo.
echo ^> ⚠️ Merge у main без оновленої документації заблокований CI/CD-пайплайном.
echo.
echo ## 4. Code Review
echo.
echo Рецензент перевіряє:
echo - Відповідність вимогам SSD
echo - Наявність unit-тестів ^(покриття ^>= 80%%^)
echo - Стиль коду ^(SwiftLint / Detekt без попереджень^)
echo - Оновлення документації при зміні вимог або API
) > docs\developer\contribution-guide.md

:: ============================================================
:: .gitignore
:: ============================================================
(
echo .env
echo site/
echo __pycache__/
echo *.pyc
echo .DS_Store
echo Thumbs.db
) > .gitignore

echo.
echo === Структура файлів створена успішно! ===
echo.
echo Тепер виконай команди нижче:
echo.
echo   git add .
echo   git commit -m "docs: initial DaC structure for Rozetka Mobile (Lab 8)"
echo   git push origin main
echo.
echo Після push — сайт буде доступний через GitHub Pages після налаштування.
pause
