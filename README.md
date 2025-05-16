# 📘 프로젝트 이름

> ## 단어바이미 단바미

---

## 📷 스크린샷

| 메인 화면 | 생성 화면 | 상세 화면 | 수정 화면 | 통계 화면
|-----------|-----------|-----------|-----------|-----------|
| ![main](./screenshots/main.png) | ![detail](./screenshots/detail.png) | ![detail](./screenshots/detail.png) | ![detail](./screenshots/detail.png) | ![detail](./screenshots/detail.png) |

---

## 📦 기술 스택

- **Language**: Swift
- **Framework**: SwiftUI
- **Data**: SwiftData 
- **Architecture**: MVVM
- **지원 OS**: iOS 16+

---

## 🚀 주요 기능

- [x] 단어 등록, 수정, 삭제
- [x] 검색
- [x] 태그 필터링 기능
- [x] 월별 통계 차트

---

## 🧑‍💻 프로젝트 구조

```
Team7/
├── Model/ # 데이터 모델 (Tag, Word)
│ ├── Tag.swift
│ └── Word.swift
│
├── Preview Content/ # 프리뷰 전용 샘플 데이터
│
├── Utils/ # 유틸리티 및 공통 기능
│
├── Views/ # 전체 화면 및 컴포넌트 뷰
│ ├── charts/ # 통계 차트 관련 뷰
│ ├── MainPage/ # 메인 리스트 뷰
│ ├── Tag/ # 태그 관련 뷰
│ ├── WordForm/ # 단어 등록/수정 뷰
│ ├── AppView.swift
│ 
│
├── Assets/ # 이미지 및 색상 에셋
│
├── Launch Screen/ # LaunchScreen.storyboard
│
└── Team7App.swift # 앱 시작 진입점


```

## git commit convention


| 타입         | 설명                     | 예시                      |
| ---------- | ---------------------- | ----------------------- |
| `feat`     | 새로운 기능 추가              | `feat: 회고 삭제 기능 추가`     |
| `fix`      | 버그 수정                  | `fix: 카테고리 필터 동작 오류 수정` |
| `docs`     | 문서 수정 (README 등)       | `docs: README에 사용법 추가`  |
| `style`    | 코드 포맷팅, 세미콜론 등 비논리적 변경 | `style: 들여쓰기 수정`        |
| `refactor` | 리팩토링 (동작은 그대로, 구조 개선)  | `refactor: 구조체 코드 정리`   |
| `test`     | 테스트 코드 추가 / 수정         | `test: 회고 저장 테스트 추가`    |
| `chore`    | 빌드, 설정, 기타 변경          | `chore: Xcode 설정 변경`    |
| `ui`       | UI 관련 변경               | `ui: 버튼 디자인 변경`         |


