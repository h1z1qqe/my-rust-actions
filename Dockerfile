# ---- Этап 1: Сборка приложения ----
FROM rust:1-slim AS builder
WORKDIR /app
# Копируем файлы с зависимостями
COPY Cargo.toml Cargo.lock ./
# Создаём фиктивный main.rs для сборки зависимостей
RUN mkdir src && echo "fn main() {}" > src/main.rs
RUN cargo build --release && rm -f target/release/my-rust-app*
# Копируем реальный исходный код и собираем
COPY src ./src
RUN cargo build --release
# ---- Этап 2: Минимальный образ для запуска ----
FROM debian:stable-slim
# Создаём непривилегированного пользователя
RUN useradd --create-home appuser
WORKDIR /home/appuser
# Копируем скомпилированный бинарник
COPY --from=builder /app/target/release/my-rust-app .
# Переключаемся на пользователя
USER appuser
# Запуск приложения
CMD ["./my-rust-app"]