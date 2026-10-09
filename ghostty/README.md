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

- theme: `TokyoNight Night` (Neovim과 같은 배경색 `#1a1b26`)
- font: `Maple Mono NF`, `Light` 스타일, 14pt, macOS thickening 비활성화
- 줄 간격: `adjust-cell-height = 30%` (기본 셀 높이보다 30% 증가)
- opacity: `1` (불투명), blur 비활성화
- 비활성 split: 밝기 유지 (`unfocused-split-opacity = 1`)
- shell integration: `zsh`
- Option key: `Alt`로 사용
- clipboard: 읽기/쓰기 허용, 선택 시 clipboard 복사
- quick terminal: `Cmd+\``

`Maple Mono NF` 글꼴을 먼저 설치해. macOS에서는 아래 명령으로 설치할 수 있어.

```bash
brew install --cask font-maple-mono-nf
```

변경 후 `Cmd+R`로 리로드하고 Neovim을 재시작해. 글자 크기를 수동으로 바꾼 기존 탭은 리로드해도 크기가 유지되므로 새 탭을 열어.
줄 간격은 Neovim 설정이 아니라 Ghostty 셀 높이로 조절하며, 터미널 전체에 적용돼.

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
