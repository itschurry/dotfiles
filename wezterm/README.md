# WezTerm

## 목적

Ubuntu, Windows, macOS에서 같은 터미널 UI와 split/tab 키 바인딩을 쓰기 위한 WezTerm 공통 설정이다. Windows에서만 시작 shell을 WSL `Ubuntu-24.04`로 고정한다.

## 설치

Ubuntu:

```bash
ln -sfn /home/user/dotfiles/wezterm/wezterm.lua ~/.wezterm.lua
```

macOS:

```bash
ln -sfn "$HOME/dotfiles/wezterm/wezterm.lua" "$HOME/.wezterm.lua"
```

Windows:

```powershell
New-Item -ItemType SymbolicLink `
  -Path "$env:USERPROFILE\.wezterm.lua" `
  -Target "\\wsl.localhost\Ubuntu-24.04\home\user\dotfiles\wezterm\wezterm.lua" `
  -Force
```

## 실행

Ubuntu/macOS:

```bash
wezterm
```

Windows:

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
- window decoration: 제목 표시줄 표시, resize 유지
- title: Ubuntu/macOS는 WezTerm 기본 제목 사용, Windows는 `Ubuntu`로 표시
- cursor: bar
- clipboard: `Ctrl+Shift+C/V`, `Super+C/V`, drag 선택 완료 복사 후 선택 해제, 우클릭 복사 후 선택 해제
- mouse: 입력 중 cursor 숨김

## 키 바인딩

- `Alt+h/j/k/l`: split 이동
- `Alt+v`: 오른쪽 split 생성
- `Alt+s`: 아래 split 생성
- `Alt+Shift+h/j/k/l`: split 크기 조절
- `Alt+q`: 현재 pane 닫기
- `Alt+Enter`: split zoom 토글
- `Alt+e`: 비활성화
- `Ctrl+Shift+c` / `Ctrl+Shift+v`: 복사/붙여넣기
- `Super+c` / `Super+v`: 복사/붙여넣기
- `Ctrl+t`: 새 tab 생성
- `Alt+Shift+[` / `Alt+Shift+]`: 이전/다음 tab 이동
- `Alt+Shift+LeftBracket` / `Alt+Shift+RightBracket`: 물리 키 위치 기준 tab 이동
- `Alt+{` / `Alt+}`: `Shift+[` / `Shift+]`가 `{` / `}`로 들어오는 경우용 tab 이동
- `Alt+Shift+{` / `Alt+Shift+}`: OS/키보드 레이아웃 해석 차이 대응용 tab 이동
- `Super+R`: 설정 리로드

## 마우스

- drag 선택 완료: 선택 영역을 clipboard/primary selection에 복사하고 선택 해제
- 선택 후 우클릭: 선택 영역을 clipboard에 복사하고 선택 해제

## 단축키 디버깅

설정 파일 연결 확인:

```bash
ls -l ~/.wezterm.lua
```

Linux/macOS에서 dotfiles의 `wezterm/wezterm.lua`를 가리켜야 한다.

WezTerm 키 바인딩 로드 확인:

```bash
WEZTERM_CONFIG_FILE="$HOME/.wezterm.lua" wezterm show-keys --lua | rg "ActivateTabRelative|LeftBracket|RightBracket"
```

`SHIFT|ALT [` / `SHIFT|ALT ]`가 보이면 WezTerm 설정은 적용된 거다.

Ubuntu에서 `Alt+Shift+[` / `Alt+Shift+]`가 안 먹으면 OS 입력 소스 전환 키가 먼저 잡고 있는지 확인해라:

```bash
gsettings get org.gnome.desktop.input-sources xkb-options
```

`grp:alt_shift_toggle`이 보이면 이게 원인이다. 끄려면:

```bash
gsettings set org.gnome.desktop.input-sources xkb-options "[]"
```

Windows에서 안 먹으면 OS가 `Alt+Shift`를 입력 언어 전환 키로 먼저 잡고 있는지 봐라. Windows 설정에서 `고급 키보드 설정` → `입력 언어 바로 가기 키` → `입력 언어 간`을 `할당되지 않음`으로 바꿔라.

macOS에서 안 먹으면 시스템 키보드 단축키나 입력 소스 전환에 `Option+Shift` 계열이 묶였는지 확인해라. OS가 먼저 잡으면 WezTerm 설정은 호출되지 않는다.

## 비활성화한 기본 키

split/tab 이동은 Alt 기반 키만 쓴다.

- `Super+D`, `Super+Shift+D`: 기본 split 생성 해제
- `Super+Alt+방향키`: 기본 split 이동 해제
- `Ctrl+Shift+T`: 기본 tab 생성 해제
- `Ctrl+Tab`, `Ctrl+Shift+Tab`, `Super+Shift+[` / `Super+Shift+]`: 기본 tab 이동 해제
- `Super+Shift+{` / `Super+Shift+}`: OS/키보드 레이아웃 해석 차이 대응용 tab 이동 해제
- `Super+1..9`: 기본 tab 번호 이동 해제

## Ghostty와 다른 점

WezTerm에는 Ghostty의 `equalize_splits`와 ``global:cmd+` `` quick terminal에 해당하는 1:1 기본 액션이 없다. 다른 동작으로 대신 묶으면 키 의미가 깨지니까 `Alt+e`는 비워둔다.
