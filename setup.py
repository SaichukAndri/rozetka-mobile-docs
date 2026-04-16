import os

def write(path, content):
    os.makedirs(os.path.dirname(path), exist_ok=True) if os.path.dirname(path) else None
    with open(path, 'w', encoding='utf-8') as f:
        f.write(content)
    print(f"  створено: {path}")

print("=== Створення структури документації Rozetka Mobile ===\n")

# README.md
write("README.md", """# Rozetka Mobile — Documentation Hub

Мобільний застосунок Rozetka для iOS та Android.

## Навігація по документації

### Архітектура
- [System Specification (SSD)](docs/architecture/SSD.md) — вимоги до системи
- [Software Design (SDD)](docs/architecture/SDD.md) — архітектура та компоненти
- [Infrastructure (ISD)](docs/architecture/ISD.md) — хмарна інфраструктура, CI/CD

### API
- [OpenAPI Специфікація](docs/api/openapi.yaml) — контракт REST API

### Якість
- [Test Strategy](docs/quality/test-strategy.md) — стратегія тестування
- [Traceability Matrix](docs/quality/traceability-matrix.md) — матриця вимог/тестів

### Розробникам
- [Onboarding Guide](docs/developer/onboarding.md) — старт для нових розробників
- [Contribution Guide](docs/developer/contribution-guide.md) — правила PR та review

## Версія документації

Поточна версія: **v2.1.0** (відповідає release/2.1.0 застосунку)
""")

# CHANGELOG.md
write("CHANGELOG.md", """# Changelog — Rozetka Mobile Documentation

## [v2.1.0] — 2026-03-15

### Додано
- SDD: описано новий модуль AR-preview товарів (FR-10)
- openapi.yaml: додано ендпоінт GET /api/v2/products/{id}/ar-model

### Змінено
- SSD: уточнено вимогу FR-01 (голосовий пошук тепер P0)
- traceability-matrix.md: додано TC-23, TC-24 для FR-10

## [v2.0.0] — 2026-01-20

### Breaking Changes
- openapi.yaml: ендпоінт /api/v1/cart замінено на /api/v2/cart
- Оновлено SDD (розділ 4.3) та Onboarding Guide
""")

# mkdocs.yml
write("mkdocs.yml", """site_name: Rozetka Mobile Documentation
site_url: https://SaichukAndri.github.io/rozetka-mobile-docs/
site_description: Документація мобільного застосунку Rozetka

theme:
  name: material
  language: uk
  palette:
    - scheme: default
      primary: indigo
      accent: orange
  features:
    - navigation.tabs
    - navigation.sections
    - search.suggest
    - content.code.copy

nav:
  - Головна: README.md
  - Архітектура:
    - 'Вимоги (SSD)': docs/architecture/SSD.md
    - 'Дизайн (SDD)': docs/architecture/SDD.md
    - 'Інфраструктура (ISD)': docs/architecture/ISD.md
  - API:
    - 'OpenAPI Специфікація': docs/api/openapi.yaml
  - Якість:
    - 'Test Strategy': docs/quality/test-strategy.md
    - 'Traceability Matrix': docs/quality/traceability-matrix.md
  - Розробникам:
    - 'Onboarding': docs/developer/onboarding.md
    - 'Contribution Guide': docs/developer/contribution-guide.md

plugins:
  - search
  - git-revision-date-localized:
      enable_creation_date: true

markdown_extensions:
  - tables
  - admonition
  - pymdownx.highlight
  - pymdownx.superfences
""")

# SSD.md
write("docs/architecture/SSD.md", """# System Specification Document — Rozetka Mobile

> Це джерело істини (SSoT) для всіх функціональних вимог.
> Test Strategy та Traceability Matrix посилаються на ідентифікатори FR з цього документа.

## 1. Призначення системи

Rozetka Mobile забезпечує мобільний доступ до українського маркетплейсу Rozetka для кінцевих споживачів. Застосунок дозволяє здійснювати повний цикл купівлі — від пошуку товару до отримання замовлення — безпосередньо зі смартфона.

## 2. Межі системи

**Охоплює:**
- Мобільний клієнт (iOS >= 15, Android >= 9)
- Взаємодію з Rozetka REST API
- Інтеграцію з платіжними шлюзами та службами доставки
- Push-сповіщення через FCM (Android) та APNs (iOS)

**НЕ охоплює:**
- Серверну логіку бекенду та адміністративну панель
- Веб-версію Rozetka.ua
- Внутрішні системи складського обліку

## 3. Функціональні вимоги

| ID | Функція | Опис | Пріоритет |
|---|---|---|---|
| FR-01 | Пошук товарів | Пошук за назвою, штрихкодом, голосом; автодоповнення | P0 |
| FR-02 | Фільтрація каталогу | Фільтрація за ціною, брендом, рейтингом, наявністю | P2 |
| FR-03 | Картка товару | Перегляд фото, характеристик, відгуків, порівняння | P2 |
| FR-04 | Кошик | Додавання/видалення товарів, зміна кількості, розрахунок | P1 |
| FR-05 | Оформлення замовлення | Вибір доставки, оплати, підтвердження | P0 |
| FR-06 | Відстеження замовлення | Статус замовлення, номер ТТН, push-сповіщення | P1 |
| FR-07 | Автентифікація | Реєстрація, логін, OAuth (Google, Apple), відновлення паролю | P0 |
| FR-08 | Wishlist | Список бажань, сповіщення про зміну ціни | P2 |
| FR-09 | Відгуки | Читання та написання відгуків після покупки | P2 |

## 4. Нефункціональні вимоги

| Категорія | Вимога |
|---|---|
| Продуктивність | Завантаження головного екрану до 2 секунд (4G) |
| Продуктивність | Результати пошуку — до 1.5 секунди |
| Доступність | SLA серверного API — не менше 99.9% |
| Безпека | TLS 1.3, certificate pinning, Keychain/EncryptedSharedPreferences |
| Безпека | Підтримка Face ID / Fingerprint |
| Сумісність | iOS >= 15 (iPhone 8+), Android >= 9 (API 28+) |
| Розмір | Не більше 100 MB після встановлення |
""")

# SDD.md
write("docs/architecture/SDD.md", """# Software Design Document — Rozetka Mobile

> Посилання на вимоги: [SSD.md](SSD.md)
> Посилання на інфраструктуру: [ISD.md](ISD.md)

## 1. Загальна архітектура

Застосунок побудований за патерном **MVVM + Clean Architecture**. Платформи iOS та Android мають окремі нативні кодові бази зі спільними модулями через **Kotlin Multiplatform Mobile (KMM)**.

**Архітектурні шари:**
- **Presentation Layer** — SwiftUI (iOS) / Jetpack Compose (Android), ViewModel
- **Domain Layer** — Use Cases, Repository Interfaces, Domain Models (KMM)
- **Data Layer** — API-клієнти, локальна БД, Repository implementations (KMM)
- **Infrastructure** — DI (Hilt/Koin), аналітика, crash-репортинг

## 2. Основні компоненти

| Компонент | Технологія | Відповідальність |
|---|---|---|
| Search Module | Algolia SDK + REST | Пошук, автодоповнення, голосовий пошук |
| Catalog Module | REST API + Room/CoreData | Каталог, фільтрація, кешування |
| Cart Module | Local DB + REST | Кошик, синхронізація з сервером |
| Checkout Module | REST API | Оформлення замовлення, доставка/оплата |
| Payment Module | LiqPay SDK, Apple/Google Pay | Обробка платежів, токенізація |
| Auth Module | OAuth 2.0 / JWT | Автентифікація, токени, biometrics |
| Notification Module | FCM / APNs | Push-сповіщення, in-app нотифікації |
| Analytics Module | Firebase Analytics | Поведінка користувача, конверсії |
| Image Module | Glide / Kingfisher | Завантаження та кешування зображень |

## 3. API-ендпоінти

Усі модулі взаємодіють через єдиний REST API Gateway. Формат — JSON. Автентифікація — Bearer JWT (TTL: 1 год), refresh token — 30 днів.

| Метод | Ендпоінт | Модуль | Опис |
|---|---|---|---|
| GET | /api/v2/catalog/search | Search | Пошук з фільтрами |
| GET | /api/v2/products/{id} | Catalog | Картка товару |
| GET/POST | /api/v2/cart | Cart | Кошик |
| POST | /api/v2/orders | Checkout | Створення замовлення |
| GET | /api/v2/orders/{id} | Orders | Статус замовлення |
| POST | /api/v2/auth/login | Auth | Логін |
| POST | /api/v2/auth/refresh | Auth | Оновлення токена |
| GET/POST | /api/v2/wishlist | Wishlist | Список бажань |

## 4. Локальне сховище

- **Room / CoreData** — кошик, wishlist, кеш каталогу
- **Keychain / EncryptedSharedPreferences** — токени автентифікації
- **In-Memory Cache** — результати пошуку (TTL: 5 хв), зображення
- **Офлайн-режим** — остання головна сторінка та кошик без мережі
""")

# ISD.md
write("docs/architecture/ISD.md", """# Infrastructure Specification Document — Rozetka Mobile

> Посилання на компоненти: [SDD.md](SDD.md)

## 1. Середовище розгортання

Серверна частина розгорнута у **AWS** (регіон: eu-central-1, Frankfurt). Застосунок поширюється через **App Store** (iOS) та **Google Play** (Android).

## 2. Інфраструктурні компоненти

| Компонент | Технологія | Призначення |
|---|---|---|
| API Gateway | AWS API Gateway | Маршрутизація, rate limiting |
| Load Balancer | AWS ALB | Розподіл трафіку |
| Контейнеризація | Docker + Kubernetes (EKS) | Оркестрація, auto-scaling |
| База даних | PostgreSQL (RDS) | Замовлення, користувачі, товари |
| Кеш | Redis (ElastiCache) | Каталог, сесії, rate limiting |
| Пошук | Algolia | Повнотекстовий пошук товарів |
| CDN | AWS CloudFront | Зображення товарів, статичні ресурси |
| Push | FCM + APNs via AWS SNS | Push-нотифікації |
| Моніторинг | Datadog + CloudWatch | Метрики, логи, алерти |
| CI/CD | GitHub Actions + Fastlane | Збірка, тестування, публікація |
| Crash Reporting | Firebase Crashlytics | Аналіз крашів |

## 3. CI/CD Pipeline (Mobile)

1. Developer робить push у feature-гілку → тригер GitHub Actions
2. Запуск unit-тестів та статичного аналізу (SwiftLint / Detekt)
3. Збірка debug-версії → UI-тести на емуляторах
4. Merge в develop → TestFlight (iOS) / Firebase App Distribution (Android)
5. QA-тестування на реальних пристроях
6. Merge в main → Fastlane публікує у App Store / Google Play (10% → 50% → 100%)

## 4. Масштабування

- Kubernetes HPA: авто-додавання подів при CPU > 70%
- PostgreSQL Read Replicas для зменшення навантаження
- Redis кластер, TTL кешу каталогу: 15 хвилин
- Blue-Green Deployment — нульовий downtime
- Feature Flags через LaunchDarkly
""")

# test-strategy.md
write("docs/quality/test-strategy.md", """# Test Strategy — Rozetka Mobile

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
""")

# traceability-matrix.md
write("docs/quality/traceability-matrix.md", """# Traceability Matrix — Rozetka Mobile

> Вимоги: [SSD.md](../architecture/SSD.md) | Стратегія: [test-strategy.md](test-strategy.md)

## Матриця простежуваності

| Вимога | Опис вимоги | Тест-кейси | Пріоритет | Статус |
|---|---|---|---|---|
| FR-01 | Пошук товарів | TC-01, TC-02, TC-03 | P0 | Ready |
| FR-02 | Фільтрація каталогу | TC-04, TC-05 | P2 | Ready |
| FR-03 | Картка товару | TC-06, TC-07 | P2 | Ready |
| FR-04 | Кошик | TC-08, TC-09, TC-10 | P1 | Ready |
| FR-05 | Оформлення замовлення | TC-11, TC-12, TC-13 | P0 | Ready |
| FR-06 | Відстеження замовлення | TC-14, TC-15 | P1 | Ready |
| FR-07 | Автентифікація | TC-16, TC-17, TC-18 | P0 | Ready |
| FR-08 | Wishlist | TC-19, TC-20 | P2 | In Progress |
| FR-09 | Відгуки | TC-21, TC-22 | P2 | In Progress |

## Критичні тест-кейси

| ID | Назва | Кроки | Очікуваний результат |
|---|---|---|---|
| TC-11 | Успішне оформлення замовлення | Додати товар → Кошик → Checkout → Картка → Підтвердити | Замовлення створено, push отримано |
| TC-16 | Логін через email | Ввести email + пароль → Увійти | Перехід до головної, токен збережено |
| TC-17 | Логін через Google OAuth | Google → обрати акаунт → підтвердити | Авторизація успішна, профіль синхронізовано |
| TC-01 | Пошук за назвою | Ввести 'iPhone 15' у пошук | Список товарів за < 1.5 с |
| TC-08 | Додавання до кошика | Картка товару → Купити | Товар у кошику, лічильник оновлено |
""")

# openapi.yaml
write("docs/api/openapi.yaml", """openapi: 3.0.3
info:
  title: Rozetka Mobile API
  description: REST API для мобільного застосунку Rozetka Mobile
  version: 2.1.0
  contact:
    name: Rozetka Mobile Team

servers:
  - url: https://api.rozetka.com.ua
    description: Production
  - url: https://api-staging.rozetka.com.ua
    description: Staging

security:
  - BearerAuth: []

paths:
  /api/v2/catalog/search:
    get:
      summary: Пошук товарів
      tags: [Search]
      parameters:
        - name: q
          in: query
          required: true
          schema:
            type: string
          description: Пошуковий запит
        - name: page
          in: query
          schema:
            type: integer
            default: 1
        - name: limit
          in: query
          schema:
            type: integer
            default: 20
      responses:
        '200':
          description: Список товарів
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ProductList'
        '400':
          description: Некоректний запит

  /api/v2/products/{id}:
    get:
      summary: Картка товару
      tags: [Catalog]
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: string
      responses:
        '200':
          description: Деталі товару
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Product'
        '404':
          description: Товар не знайдено

  /api/v2/cart:
    get:
      summary: Отримати кошик
      tags: [Cart]
      responses:
        '200':
          description: Вміст кошика
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Cart'
    post:
      summary: Додати товар до кошика
      tags: [Cart]
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/CartItem'
      responses:
        '200':
          description: Кошик оновлено
        '400':
          description: Некоректні дані

  /api/v2/orders:
    post:
      summary: Створити замовлення
      tags: [Checkout]
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/OrderRequest'
      responses:
        '201':
          description: Замовлення створено
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Order'
        '400':
          description: Некоректні дані замовлення
        '402':
          description: Помилка оплати

  /api/v2/orders/{id}:
    get:
      summary: Статус замовлення
      tags: [Orders]
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: string
      responses:
        '200':
          description: Деталі замовлення
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Order'
        '404':
          description: Замовлення не знайдено

  /api/v2/auth/login:
    post:
      summary: Логін користувача
      tags: [Auth]
      security: []
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/LoginRequest'
      responses:
        '200':
          description: Успішна авторизація
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/AuthTokens'
        '401':
          description: Невірні дані

  /api/v2/auth/refresh:
    post:
      summary: Оновлення access token
      tags: [Auth]
      security: []
      requestBody:
        required: true
        content:
          application/json:
            schema:
              type: object
              properties:
                refresh_token:
                  type: string
      responses:
        '200':
          description: Новий access token
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/AuthTokens'
        '401':
          description: Refresh token недійсний

  /api/v2/wishlist:
    get:
      summary: Список бажань
      tags: [Wishlist]
      responses:
        '200':
          description: Товари у wishlist
    post:
      summary: Додати товар до wishlist
      tags: [Wishlist]
      requestBody:
        required: true
        content:
          application/json:
            schema:
              type: object
              properties:
                product_id:
                  type: string
      responses:
        '201':
          description: Додано до wishlist

components:
  securitySchemes:
    BearerAuth:
      type: http
      scheme: bearer
      bearerFormat: JWT

  schemas:
    Product:
      type: object
      properties:
        id:
          type: string
        name:
          type: string
        price:
          type: number
        currency:
          type: string
          example: UAH
        images:
          type: array
          items:
            type: string
        rating:
          type: number
          minimum: 0
          maximum: 5
        in_stock:
          type: boolean

    ProductList:
      type: object
      properties:
        items:
          type: array
          items:
            $ref: '#/components/schemas/Product'
        total:
          type: integer
        page:
          type: integer

    CartItem:
      type: object
      properties:
        product_id:
          type: string
        quantity:
          type: integer
          minimum: 1

    Cart:
      type: object
      properties:
        items:
          type: array
          items:
            $ref: '#/components/schemas/CartItem'
        total_price:
          type: number

    OrderRequest:
      type: object
      required: [delivery, payment]
      properties:
        delivery:
          type: object
          properties:
            method:
              type: string
              enum: [nova_poshta, ukrposhta, courier]
            address:
              type: string
        payment:
          type: object
          properties:
            method:
              type: string
              enum: [card, apple_pay, google_pay, liqpay]

    Order:
      type: object
      properties:
        id:
          type: string
        status:
          type: string
          enum: [pending, confirmed, shipped, delivered, cancelled]
        ttn:
          type: string
          description: Номер ТТН
        created_at:
          type: string
          format: date-time

    LoginRequest:
      type: object
      required: [email, password]
      properties:
        email:
          type: string
          format: email
        password:
          type: string

    AuthTokens:
      type: object
      properties:
        access_token:
          type: string
        refresh_token:
          type: string
        expires_in:
          type: integer
          description: Секунди до закінчення дії access token
""")

# onboarding.md
write("docs/developer/onboarding.md", """# Onboarding Guide — Rozetka Mobile

> Архітектура системи: [SDD.md](../architecture/SDD.md)
> Правила контрибуції: [contribution-guide.md](contribution-guide.md)

## 1. Вимоги до середовища

- **iOS:** Xcode 15+, Swift 5.9+, CocoaPods або SPM
- **Android:** Android Studio Hedgehog+, Kotlin 1.9+, Gradle 8+
- **Спільне:** Git, GitHub CLI, Python 3.10+

## 2. Клонування та запуск

```bash
git clone https://github.com/rozetka-team/rozetka-mobile.git
cd rozetka-mobile
```

**iOS:**
```bash
cd ios
pod install
open RozetkaMobile.xcworkspace
```

**Android:**
```bash
cd android
./gradlew assembleDebug
```

## 3. Конфігурація

Скопіюй `.env.example` у `.env` та заповни змінні:
- `API_BASE_URL` — URL серверного API
- `ALGOLIA_APP_ID` — ідентифікатор Algolia
- `FIREBASE_CONFIG` — шлях до google-services.json

> ⚠️ Ніколи не комітуй `.env` у репозиторій. Він вже є у `.gitignore`.

## 4. Перший PR

1. Створи гілку: `git checkout -b feature/твоя-задача`
2. Внеси зміни та закомітуй
3. Відкрий Pull Request у `develop`
4. Дочекайся Code Review та CI green

Правила PR описані у [contribution-guide.md](contribution-guide.md).
""")

# contribution-guide.md
write("docs/developer/contribution-guide.md", """# Contribution Guide — Rozetka Mobile

## 1. Гілки

- `main` — production-ready код
- `develop` — інтеграційна гілка
- `feature/*` — нові функції
- `fix/*` — виправлення багів
- `docs/*` — зміни документації

## 2. Правила комітів

Використовуємо Conventional Commits:

```
feat: додано голосовий пошук (FR-01)
fix: виправлено синхронізацію кошика (FR-04)
docs: оновлено SSD — вимога FR-01 стала P0
```

## 3. Pull Request

- PR відкривається лише в `develop`
- Обов'язковий Code Review від 1 розробника
- CI має бути green (тести, лінтер)
- **Зміна функціональної вимоги → обов'язково оновити SSD.md у тому ж PR**
- **Зміна API → обов'язково оновити openapi.yaml**

> ⚠️ Merge у main без оновленої документації заблокований CI/CD-пайплайном.

## 4. Code Review

Рецензент перевіряє:
- Відповідність вимогам SSD
- Наявність unit-тестів (покриття >= 80%)
- Стиль коду (SwiftLint / Detekt без попереджень)
- Оновлення документації при зміні вимог або API
""")

# .gitignore
write(".gitignore", """.env
site/
__pycache__/
*.pyc
.DS_Store
Thumbs.db
""")

print("\n=== Готово! Всі файли створено успішно ===")
print("\nТепер введи в cmd:")
print('  git add .')
print('  git commit -m "docs: initial DaC structure for Rozetka Mobile (Lab 8)"')
print('  git push origin main')
