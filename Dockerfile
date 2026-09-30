# ---- Этап 1: Сборка приложения ----
FROM rust:1-slim AS builder
WORKDIR /app
COPY . .
RUN cargo build --release

# ---- Этап 2: Минимальный образ для запуска ----
FROM debian:stable-slim
RUN useradd --create-home appuser
WORKDIR /home/appuser
COPY --from=builder /app/target/release/my-rust-app .
USER appuser
CMD ["./my-rust-app"]