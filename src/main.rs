use std::io::{self, Write};

fn main() {
    println!("Hello from Rust in Docker! 🦀");
    // Принудительный сброс буфера вывода
    io::stdout().flush().unwrap();
    // Небольшая задержка для гарантии вывода в контейнере
    std::thread::sleep(std::time::Duration::from_millis(200));
}