# UI Documentation — Storybook

> Візуальна документація UI-компонентів мобільного застосунку Rozetka Mobile.
> Компоненти описані у форматі Stories — кожен стан компонента є окремою Story.

## Що таке Storybook?

Storybook — інструмент для ізольованої розробки та документування UI-компонентів.
Кожен компонент описується через набір Stories — різних станів відображення.
Це дозволяє розробникам і дизайнерам бачити компонент окремо від решти застосунку.

---

## Компонент 1: ProductCard (Картка товару)

Відображає інформацію про товар у каталозі: фото, назву, ціну, рейтинг і кнопку додавання до кошика.

### Stories

#### Default — базовий стан
```
ProductCard {
  image: "https://cdn.rozetka.com.ua/iphone15.jpg"
  name: "Apple iPhone 15 128GB Black"
  price: 34999
  currency: "UAH"
  rating: 4.8
  inStock: true
}
```
Відображення: фото товару, назва, ціна виділена жирним, зірки рейтингу, активна кнопка "Купити".

#### OutOfStock — товар відсутній
```
ProductCard {
  image: "https://cdn.rozetka.com.ua/iphone15.jpg"
  name: "Apple iPhone 15 128GB Black"
  price: 34999
  currency: "UAH"
  rating: 4.8
  inStock: false
}
```
Відображення: кнопка "Купити" неактивна (disabled), напис "Немає в наявності" сірим кольором.

#### WithDiscount — товар зі знижкою
```
ProductCard {
  image: "https://cdn.rozetka.com.ua/iphone15.jpg"
  name: "Apple iPhone 15 128GB Black"
  price: 29999
  oldPrice: 34999
  currency: "UAH"
  rating: 4.8
  inStock: true
  discount: 14
}
```
Відображення: стара ціна перекреслена, нова ціна червоним, бейдж "-14%" у куті картки.

#### Loading — стан завантаження
```
ProductCard {
  loading: true
}
```
Відображення: skeleton-анімація (сірі прямокутники замість контенту).

---

## Компонент 2: AddToCartButton (Кнопка додавання до кошика)

Кнопка яка додає товар до кошика. Використовується на картці товару та сторінці товару.

### Stories

#### Default — базовий стан
```
AddToCartButton {
  label: "Купити"
  variant: "primary"
  disabled: false
}
```
Відображення: синя кнопка з текстом "Купити", активна, реагує на натискання.

#### Disabled — неактивний стан
```
AddToCartButton {
  label: "Немає в наявності"
  variant: "primary"
  disabled: true
}
```
Відображення: сіра кнопка, курсор not-allowed, не реагує на натискання.

#### Loading — стан завантаження після натискання
```
AddToCartButton {
  label: "Додається..."
  variant: "primary"
  disabled: true
  loading: true
}
```
Відображення: спінер замість тексту, кнопка неактивна поки йде запит до сервера.

#### Success — товар додано
```
AddToCartButton {
  label: "Додано ✓"
  variant: "success"
  disabled: false
}
```
Відображення: зелена кнопка з галочкою, через 2 секунди повертається до стану Default.

---

## Запуск Storybook (для розробників)

```bash
# Встановлення
npx storybook@latest init

# Запуск локально
npm run storybook

# Збірка статичного сайту
npm run build-storybook
```

Storybook запускається на http://localhost:6006
