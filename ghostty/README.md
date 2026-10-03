# Ghostty

## 목적

Ghostty를 가벼운 터미널 레이어로 쓰고, tmux/Neovim과 충돌 없는 split/tab 키 바인딩을 관리한다.

## 설치

```bash
mkdir -p ~/.config/ghostty
ln -sfn ~/dotfiles/ghostty/config ~/.config/ghostty/config
```

## 실행

```bash
open -a Ghostty
```

설정 리로드:

```text
Cmd+R
```

## 디렉터리 구조

```text
ghostty/
├── README.md
└── config
```

## 주요 옵션

- theme: `Hardcore`
- macOS titlebar: `tabs` (타이틀바와 탭을 통합, Linux에는 적용되지 않음)
- font: `Maple Mono NF`, 14pt, thickening 비활성화
- opacity: `0.85`
- blur: `18`
- shell integration: `zsh`
- Option key: `Alt`로 사용
- clipboard: 읽기/쓰기 허용, 선택 시 clipboard 복사
- quick terminal: `Cmd+\``

## 키 바인딩

- `Alt+h/j/k/l`: split 이동
- `Alt+v`: 오른쪽 split 생성
- `Alt+s`: 아래 split 생성
- `Alt+Shift+h/j/k/l`: split 크기 조절
- `Alt+q`: 현재 surface 닫기
- `Alt+Enter`: split zoom 토글
- `Alt+e`: split 크기 균등화
- `Alt+[` / `Alt+]`: 이전/다음 tab
- `Cmd+R`: 설정 리로드
- `Cmd+\``: quick terminal 토글

## 비활성화한 기본 키

split/tab 이동은 위 Alt 기반 키만 쓴다.

- `Cmd+D`, `Cmd+Shift+D`: 기본 split 생성 해제
- `Cmd+[` / `Cmd+]`, `Cmd+Opt+방향키`: 기본 split 이동 해제
- `Ctrl+Tab`, `Ctrl+Shift+Tab`, `Cmd+Shift+[` / `Cmd+Shift+]`: 기본 tab 이동 해제
- `Cmd+1..9`: 기본 tab 번호 이동 해제

## macOS 탭 표시

`macos-titlebar-style = tabs`로 별도의 native 탭 바 대신 타이틀바에 탭을 통합한다.
활성/비활성 탭 색을 직접 지정하는 설정은 아니다. macOS의 실제 시각적 구분은 Mac에서 확인한다.
Linux GTK 1.3.1에서 공용 설정의 유효성만 검증했으며 Linux의 탭 모양은 이 옵션으로 바뀌지 않는다.

Mac에서 저장소를 갱신한 뒤 `Cmd+R`로 리로드하고 **새 창**을 열어 탭 두 개를 비교한다.
이 옵션은 기존 창에 적용되지 않으므로 필요하면 Ghostty를 완전히 종료한 뒤 다시 실행한다.
macOS 13 이하에서는 이 스타일의 저장된 탭 상태 복원에 알려진 제한이 있다.
문제가 있으면 `macos-titlebar-style = transparent`로 되돌리고 새 창을 연다.

[공식 옵션 설명](https://ghostty.org/docs/config/reference#macos-titlebar-style)
