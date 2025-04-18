# 📊 Estimate Tracker

A lightweight Flutter application for managing supplier estimates — complete with sorting, searching, and persistent local storage using Hive.

---

## ✨ Features

- 📝 Register estimates (Supplier, Item, Price, Delivery Date)
- 📋 View estimates in a list with real-time updates
- 🔍 Search by supplier or item name
- ↕️ Sort by price, date, or supplier name
- 💾 Persistent local storage with Hive
- 💡 Simple, intuitive UI built with Flutter

---

## 🧱 Project Structure

```
lib/
├── main.dart                # Entry point, Hive init
├── estimate.dart            # Hive model
├── estimate_form_page.dart  # Form & List UI
├── estimate.g.dart          # Hive adapter (auto-generated)
```

---

## 🚀 Getting Started

### 1. Install Flutter packages

```bash
flutter pub get
```

### 2. Generate Hive adapter

```bash
flutter packages pub run build_runner build
```

### 3. Run the application

```bash
flutter run
```

> Supports Android, iOS, Windows, and macOS

---

## 💾 Hive Setup Example

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(EstimateAdapter());
  await Hive.openBox<Estimate>('estimates');
  runApp(EstimateApp());
}
```

---

## 📚 Learning Resources

If you're new to Flutter, check out:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
- [Flutter Documentation](https://docs.flutter.dev/)

---

## 📝 License

This app was created as part of a software system development course.  
You may use it for educational or personal use.

---

## 👤 Author

- Yuji Sunagawa
- Nagoya Institute of Technology / Software System Development

---

## 🇯🇵 日本語版

### 概要

Estimate Tracker は、Flutter と Hive を使用して開発された、サプライヤーからの見積情報を管理する軽量なアプリケーションです。

### 主な機能

- 📝 見積の登録（会社名・品目・価格・納期）
- 📋 見積一覧の表示（リアルタイム反映）
- 🔍 サプライヤー名・品目名での検索機能
- ↕️ 価格・納期・会社名による並び替え
- 💾 Hive によるローカル永続保存
- 💡 シンプルで直感的なUI

### 起動方法（基本手順）

```bash
flutter pub get
flutter packages pub run build_runner build
flutter run
```

### プロジェクト構成

```
lib/
├── main.dart                // エントリーポイント、Hive初期化
├── estimate.dart            // 見積モデル（Hive用）
├── estimate_form_page.dart  // 入力フォーム＋リスト表示UI
├── estimate.g.dart          // Hiveアダプタ（自動生成）
```

### 使用技術
- Flutter 3.x
- Hive 2.x（ローカル保存）
- build_runner / hive_generator（アダプタ生成）

### 作者
- 砂川優治
- 名古屋国際工科専門職大学