# NileTech Tour Guide — Project Init

You are working on **NileTech Tour Guide**, a Flutter mobile app for professional tour guides built on the **Thoth Platform** (Laravel backend).

---

## Architecture

**Pattern**: MVVM + Repository Pattern + Dependency Injection (GetIt)
**State Management**: `flutter_bloc` Cubits as ViewModels
**DI Container**: `get_it` — all wiring lives in `lib/core/di/locator.dart`
**Navigation**: `go_router` — all route names in `lib/core/router/app_routes.dart`

### SOLID Principles Applied
- **S** — Each class has one job: models parse JSON, repositories call APIs, cubits manage state, views display UI
- **O** — Repositories are abstract interfaces (`IXxxRepository`); swap implementations without touching cubits
- **L** — Every concrete repository fully satisfies its interface contract
- **I** — Interfaces are feature-scoped and small; no fat interfaces
- **D** — Cubits depend on `IXxxRepository` abstractions, never on concrete classes directly

---

## Folder Structure

```
lib/
├── core/
│   ├── constants/       app_constants.dart, storage_keys.dart
│   ├── di/              locator.dart          ← GetIt setup
│   ├── network/         api_client.dart, api_response.dart
│   ├── router/          app_router.dart, app_routes.dart
│   ├── storage/         app_storage.dart      ← secure storage wrapper
│   ├── theme/           app_colors.dart, app_text_styles.dart, app_theme.dart
│   └── utils/           extensions.dart, validators.dart
│
├── features/
│   └── <feature>/
│       ├── model/        <feature>_model.dart      ← plain Dart + fromJson
│       ├── repository/
│       │   ├── i_<feature>_repository.dart          ← abstract interface (DIP)
│       │   └── <feature>_repository.dart            ← concrete impl (Dio calls)
│       ├── viewmodel/    <feature>_cubit.dart       ← states + Cubit, injects interface
│       └── view/         <feature>_page.dart        ← StatelessWidget + BlocConsumer
│
├── shared/
│   └── widgets/  app_button.dart, app_text_field.dart, loading_overlay.dart, error_view.dart
│
└── main.dart             ← calls setupLocator() then runApp()
```

**Features**: `auth`, `home`, `profile`, `verification`, `marketplace`, `subscription`, `wallet`, `commissions`, `referrals`, `support`, `notifications`, `knowledge_center`, `agreements`

---

## Key Conventions

### Adding a New Feature
1. Create `model/` → plain class + `fromJson`
2. Create `repository/i_feature_repository.dart` → abstract interface
3. Create `repository/feature_repository.dart` → implements interface, injects `Dio`
4. Create `viewmodel/feature_cubit.dart` → injects `IFeatureRepository`, states + logic
5. Create `view/feature_page.dart` → `BlocConsumer<FeatureCubit, FeatureState>`
6. Register in `core/di/locator.dart`:
   ```dart
   locator.registerLazySingleton<IFeatureRepository>(() => FeatureRepository(locator()));
   locator.registerFactory(() => FeatureCubit(locator()));
   ```
7. Add route in `core/router/app_routes.dart` + `app_router.dart`

### Cubit Template
```dart
class FeatureCubit extends Cubit<FeatureState> {
  final IFeatureRepository _repository;          // depends on abstraction
  FeatureCubit(this._repository) : super(FeatureInitial());

  Future<void> loadData() async {
    emit(FeatureLoading());
    try {
      final data = await _repository.getData();
      emit(FeatureLoaded(data));
    } on DioException catch (e) {
      emit(FeatureError(e.response?.data['message'] ?? 'Request failed'));
    } catch (_) {
      emit(FeatureError('Something went wrong'));
    }
  }
}
```

### Providing a Cubit in a View
```dart
// Always get from locator — never new Cubit() directly
BlocProvider(
  create: (_) => locator<AuthCubit>(),
  child: const LoginPage(),
)
```

### Repository Template
```dart
class FeatureRepository implements IFeatureRepository {
  final Dio _dio;
  FeatureRepository(this._dio);

  @override
  Future<FeatureModel> getData() async {
    final response = await _dio.get('/guide/feature');
    return FeatureModel.fromJson(response.data['data']);
  }
}
```

---

## API Base URLs
```dart
AppConstants.apiBase    = 'https://api.niletech.com/api'        // public endpoints
AppConstants.guideBase  = 'https://api.niletech.com/api/guide'  // authenticated
AppConstants.thothBase  = 'https://api.niletech.com/api/thoth-guide'
```
All authenticated requests have `Authorization: Bearer <token>` injected automatically by `ApiClient`'s auth interceptor.

## Auth Flow
1. Register → save token → go to VerifyEmail
2. Login → save token → go to Home
3. 401 response → `AppStorage.deleteToken()` → router redirects to Login

## Design Tokens (never hardcode)
- Colors: `AppColors.*` — primary `#1A6B4A`, accent `#D4A017`, background `#F5F6FA`
- Text: `AppTextStyles.*` — Poppins font family
- Shared widgets: `AppButton`, `AppTextField`, `LoadingOverlay`, `ErrorView`

## State Management Rule
- States and Cubit live in the **same file** (`feature_cubit.dart`) — no `part/part of`
- Pattern: `FeatureInitial | FeatureLoading | FeatureLoaded(data) | FeatureError(message)`
