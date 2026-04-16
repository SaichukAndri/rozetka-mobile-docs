# Infrastructure Specification Document — Rozetka Mobile

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
