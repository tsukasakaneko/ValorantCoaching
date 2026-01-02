#![cfg_attr(not(debug_assertions), windows_subsystem = "windows")]

use tauri::Manager;

#[tauri::command]
fn echo(s: &str) -> String {
  format!("echo: {}", s)
}

fn main() {
  tauri::Builder::default()
    .invoke_handler(tauri::generate_handler![echo])
    .run(tauri::generate_context!())
    .expect("error while running tauri application");
}
