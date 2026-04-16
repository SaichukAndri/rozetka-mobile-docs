# Onboarding Guide — Rozetka Mobile

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
