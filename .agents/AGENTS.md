# Money Invest App - Development Guidelines & Rules

## 🏗 Architecture & Structure
This project follows a **Layer-First Architecture** inside the `lib/src/` directory:
- `app/`: App initialization and setup.
- `core/`: Core configurations, environment setups, exceptions, and constants.
- `data/`: API calls, models, data sources, and repositories.
- `presentation/`: UI-related code.
  - `ui/`: Screens and pages.
  - `components/`: Reusable widgets.
  - `logic/`: BLoCs and Cubits.
  - `resources/`: Theme, colors, typography, styles (buttons, text fields).
- `localization/`: Localization files and generated delegates.
- `utils/`: Helper classes and extensions.

## 🚀 State Management
- Primary State Management: **flutter_bloc** (and `hydrated_bloc` for caching state).
- Keep your BLoCs and Cubits inside `presentation/logic/`.
- Use `provider` sparingly, mainly for simple value propagation if necessary, but default to BLoC.

## 💉 Dependency Injection
- Use **get_it** combined with **injectable**.
- Always annotate new services, repositories, or use cases with `@injectable`, `@singleton`, or `@lazySingleton`.
- After adding a new dependency, run:
  `dart run build_runner build --delete-conflicting-outputs`

## 🛣 Routing & Navigation
- All navigation is handled by **go_router**.
- Define your routes inside a central router configuration (likely in `core` or `app` folder).
- Do not use `Navigator.push` or `Navigator.pop` unless absolutely necessary; use `context.go()` or `context.push()`.

## 🌐 Network & APIs
- Use **Dio** for HTTP requests.
- For JSON serialization, always use **json_serializable** and **json_annotation**.
- Ensure model classes include the `part 'model_name.g.dart';` directive and run build_runner.

## 🎨 UI & Styling
- Use the `gap` package (`Gap()`) for spacing instead of `SizedBox(height: ..., width: ...)` when separating widgets linearly.
- For vector graphics, use `flutter_svg` (`SvgPicture.asset`).
- The project uses custom packages (`adaptive_layout` and `ui_components`). Prefer these base components when building new UI.
- Use `presentation/resources/` for accessing standard colors, text styles, and button styles. (e.g. `ElevatedButtonTheme`, `TextButtonTheme`).
- Use `lottie` for complex animations and `shimmer` for loading placeholders.
- Always use `AppLocalizations` for strings instead of hardcoded strings in UI files.

## 🛠 Useful Commands
- Generate DI and JSON serialization: `dart run build_runner build -d`
- Fix formatting and lints: `dart fix --apply`
