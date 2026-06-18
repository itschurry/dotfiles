# WezTerm

## 목적

WezTerm을 Windows에서 WSL `Ubuntu-24.04` 진입용 터미널로 쓰고, Ghostty와 같은 split 중심 키 바인딩을 관리한다.

## 설치

```powershell
New-Item -ItemType SymbolicLink `
  -Path "$env:USERPROFILE\.wezterm.lua" `
  -Target "\\wsl.localhost\Ubuntu-24.04\home\user\dotfiles\wezterm\wezterm.lua" `
  -Force
```

## 실행

```powershell
wezterm
```

설정 리로드:

```text
Super+R
```

## 디렉터리 구조

```text
wezterm/
├── README.md
└── wezterm.lua
```

## 주요 옵션

- default shell: Windows에서만 `wsl.exe -d Ubuntu-24.04 --cd ~`
- theme: `Hardcore`
- font: `JetBrainsMono NFM`, 11pt
- opacity: `0.86`
- blur/backdrop: macOS blur `24`, Windows Acrylic
- accent color: `#0f1117`
- padding: `14px`
- tab bar: tab이 하나면 숨김, fancy tab bar/번호 비활성화
- tab title: Windows는 `Ubuntu`, 그 외 플랫폼은 `wezterm`
- window decoration: 제목 표시줄 표시, resize 유지
- window title: `wezterm`으로 고정
- cursor: bar
- clipboard: WezTerm 기본 mouse binding으로 선택 완료 시 clipboard 복사
- mouse: 입력 중 cursor 숨김

## 키 바인딩

- `Alt+h/j/k/l`: split 이동
- `Alt+v`: 오른쪽 split 생성
- `Alt+s`: 아래 split 생성
- `Alt+Shift+h/j/k/l`: split 크기 조절
- `Alt+q`: 현재 pane 닫기
- `Alt+Enter`: split zoom 토글
- `Alt+e`: 비활성화
- `Alt+Shift+[` / `Alt+Shift+]`: 이전/다음 tab 이동
- `Alt+Shift+LeftBracket` / `Alt+Shift+RightBracket`: 물리 키 위치 기준 tab 이동
- `Alt+{` / `Alt+}`: Linux 키 해석 차이 대응용 tab 이동
- `Alt+Shift+{` / `Alt+Shift+}`: Windows 키 해석 차이 대응용 tab 이동
- `Super+R`: 설정 리로드

## 비활성화한 기본 키

split/tab 이동은 Alt 기반 키만 쓴다.

- `Super+D`, `Super+Shift+D`: 기본 split 생성 해제
- `Super+Alt+방향키`: 기본 split 이동 해제
- `Ctrl+Tab`, `Ctrl+Shift+Tab`, `Super+Shift+[` / `Super+Shift+]`: 기본 tab 이동 해제
- `Super+Shift+{` / `Super+Shift+}`: Windows 키 해석 차이 대응용 tab 이동 해제
- `Super+1..9`: 기본 tab 번호 이동 해제

## Ghostty와 다른 점

WezTerm에는 Ghostty의 `equalize_splits`와 ``global:cmd+` `` quick terminal에 해당하는 1:1 기본 액션이 없다. 다른 동작으로 대신 묶으면 키 의미가 깨지니까 `Alt+e`는 비워둔다.
