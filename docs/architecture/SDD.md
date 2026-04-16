# Software Design Document — Rozetka Mobile

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
