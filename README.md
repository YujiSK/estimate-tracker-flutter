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

# 📊 Estimate Tracker (Flutter + Hive)

見積情報（サプライヤー・品目・価格・納期）をローカルで管理できる、Flutter製の軽量アプリケーションです。

## 🚀 機能一覧
- ✅ サプライヤー・品目・単価・納期の登録
- ✅ 登録済データの一覧表示・ソート
- ✅ キーワード検索
- ✅ Hiveによるローカル永続化（オフライン対応）
- ✅ Android/iOS/Windows/macOS対応

## 🧠 技術スタック
- Flutter 3.x
- Hive（ローカルNoSQL DB）
- build_runner + TypeAdapter（Hive自動生成）
- State管理：`setState`ベースの簡潔な構成

## 📁 ファイル構成（`lib/`）

| ファイル名 | 説明 |
|------------|------|
| `main.dart` | アプリ起動、Hive初期化処理 |
| `estimate.dart` | Hive対応の見積モデル |
| `estimate_form_page.dart` | 登録フォーム＋リストUI |
| `estimate.g.dart` | 自動生成されたHiveアダプタコード（build_runner） |

## 🔧 セットアップ手順

```bash
flutter pub get
flutter packages pub run build_runner build
flutter run
```

※ `build_runner` でアダプタを自動生成する必要があります。

## 🖥 対応プラットフォーム

- Android / iOS
- Windows / macOS

## 📸 スクリーンショット

> ※スクリーンショットをここに挿入（フォームUIとリストUI）

## ✨ 今後の改善案（例）

- [ ] データのエクスポート（CSV/JSON）
- [ ] Cloud Firestore対応（クラウド保存）
- [ ] UI改善（バリデーション、テーマ）

---

## 📬 制作者

**砂川優治 / Sunagawa Yuji**  
- Flutter / Laravel / MQL5 / 教育アプリ開発  
- [GitHub Portfolio](https://github.com/YujiSK)  
