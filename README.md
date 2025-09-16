# fast_app_base

A new Flutter project.

## Flutter 경고 해결 및 린트 규칙 추가 (2025-09-16)

### 해결된 경고사항들

#### 1. Deprecated API 사용 경고 해결
- **`describeEnum` → `enum.name` 변경**
  - `lib/common/data/preference/app_preferences.dart:51,72`
  - `lib/screen/main/w_menu_drawer.dart:185,199,204`

- **`standardEasing` → `Easing.standard` 변경**
  - `lib/common/widget/scaffold/transparent_scaffold.dart:30`

- **색상 투명도 API 업데이트**
  - `Color.opacity` → `Color.a` 변경
  - `Color.withOpacity()` → `Color.withValues(alpha:)` 변경
  - `lib/common/widget/scaffold/transparent_scaffold.dart:2651,2656`
  - `lib/screen/main/tab/favorite/f_favorite.dart:26`

- **`DioError` → `DioException` 변경**
  - `lib/data/network/result/api_error.dart:19`

- **`onPopInvoked` → `onPopInvokedWithResult` 변경**
  - `lib/screen/main/s_main.dart:38`

- **`background` → `surface` 변경**
  - `lib/screen/main/w_menu_drawer.dart:49`

#### 2. 불필요한 import 제거
- `package:flutter/foundation.dart` 제거
  - `lib/common/data/preference/app_preferences.dart:2`
  - `lib/screen/main/w_menu_drawer.dart:3`

#### 3. 타입 안전성 개선
- `operator ==` 파라미터 타입 수정 (`dynamic` → `Object`)
  - `lib/screen/opensource/vo_package.freezed.dart:264`

### 추가된 린트 규칙 (`analysis_options.yaml`)

#### Deprecated 사용 방지
```yaml
deprecated_member_use: error
deprecated_member_use_from_same_package: error
```

#### 타입 안전성 강화
```yaml
non_nullable_equals_parameter: error
```

#### 코딩 실수 방지
```yaml
avoid_returning_null_for_void: error
avoid_unused_constructor_parameters: error
cancel_subscriptions: error
close_sinks: error
```

#### 코드 스타일 개선
```yaml
prefer_const_constructors: error
prefer_const_declarations: error
prefer_const_literals_to_create_immutables: error
unnecessary_const: error
unnecessary_new: error
```

### 결과
- 13개의 경고 → 0개로 감소
- 향후 유사한 경고 발생을 방지하는 엄격한 린트 규칙 추가

## 빌드 오류 해결 (2025-09-16)

### 발생한 빌드 오류들

#### 1. Java-Gradle 버전 호환성 문제
**오류**: `Unsupported class file major version 65`
- **원인**: Java 21 (major version 65) 사용 중이지만 Gradle 7.6.3이 Java 21을 지원하지 않음
- **해결**:
  - Gradle 7.6.3 → 8.5 업그레이드
  - Android Gradle Plugin (AGP) 7.3.0 → 8.2.1 업그레이드
  - Kotlin 1.7.10 → 1.8.10 업그레이드
  - compileSdk 34 → 35 업그레이드

#### 2. velocity_x 패키지 호환성 문제
**오류**: `CardThemeData` API 변경 및 `intl` 버전 충돌
- **원인**: velocity_x 4.2.1이 Flutter 3.29.3의 새로운 Material API와 호환되지 않음
- **해결**:
  - velocity_x ^4.2.1 → ^4.3.1 업그레이드 (최신 Material API 지원)
  - dependency_overrides로 intl 0.19.0 강제 설정하여 버전 충돌 해결

#### 3. keyboard_utils_fork 호환성 문제
**오류**: `Unknown Kotlin JVM target: 21` 및 namespace 설정 오류
- **원인**: keyboard_utils_fork 플러그인이 Java 21/Kotlin 1.8.10과 호환되지 않음
- **해결**:
  - keyboard_utils_fork 의존성 제거
  - Flutter 네이티브 API (MediaQuery, SystemChannels)로 키보드 감지 기능 대체

### Gradle과 AGP 역할 설명

#### **Gradle이란?**
- **역할**: 빌드 자동화 도구 (Build Automation Tool)
- **기능**:
  - 소스코드 컴파일
  - 의존성 관리 (라이브러리 다운로드/연결)
  - 테스트 실행
  - APK/AAB 파일 생성
  - 코드 최적화 및 패키징

#### **Android Gradle Plugin (AGP)이란?**
- **역할**: Android 앱 빌드를 위한 Gradle 플러그인
- **기능**:
  - Android SDK와 Gradle 연결
  - Android 리소스 처리 (레이아웃, 이미지, 문자열 등)
  - DEX 파일 생성 (Java 바이트코드를 Android가 이해할 수 있는 형태로 변환)
  - 앱 서명 및 최적화
  - 다양한 빌드 타입 관리 (debug, release)

#### **Flutter 프로젝트에서의 역할**
```
Flutter 앱 빌드 과정:
1. Flutter 엔진이 Dart 코드를 네이티브 코드로 컴파일
2. AGP가 Android 부분을 처리
3. Gradle이 전체 프로젝트를 빌드하여 APK 생성
```

### 해결 후 최종 상태
- ✅ **빌드 성공**: `app-debug.apk` 생성 완료
- ✅ **velocity_x 유지**: 최신 버전(4.3.1)으로 업그레이드하여 호환성 확보
- ✅ **키보드 감지 기능 유지**: Flutter 네이티브 API로 대체하여 더 안정적인 구현
- ✅ **향후 호환성**: Java 21, Gradle 8.5, AGP 8.2.1 조합으로 최신 환경 지원

### 호환성 매트릭스 (참고용)
```
Java 21 → Gradle 8.5+ → AGP 8.2.1+
Java 17 → Gradle 7.4+ → AGP 8.0+
Java 11 → Gradle 6.7+ → AGP 7.0+
```

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
