# iTerm

## 목적

iTerm용 개인 키맵을 관리한다.

## 설치

```bash
~/dotfiles/iterm/apply-keymaps.sh
```

적용 후 iTerm을 재시작해.

## 실행

```bash
open -a iTerm
```

## 디렉터리 구조

```text
iterm/
├── README.md
├── keymaps/
│   └── my-keymap.plist
└── apply-keymaps.sh
```

## 주요 옵션

`keymaps/my-keymap.plist`가 iTerm 메뉴 단축키 프리셋이다.

| 키 | 동작 |
| --- | --- |
| `Cmd+H/J/K/L` | pane 이동 |
| `Cmd+Shift+V` | 좌우 split |
| `Cmd+Shift+S` | 상하 split |

`Cmd+H/J/K/L`은 iTerm 메뉴 단축키로 직접 넣는다.
기본 `Hide iTerm2`는 `Ctrl+Cmd+H`, `Jump to Selection`은 `Ctrl+Cmd+J`로 옮긴다. 안 옮기면 pane 이동 전에 기존 메뉴가 먼저 먹힌다.

`apply-keymaps.sh`는 예전에 잘못 넣은 `GlobalKeyMap` pane 항목을 먼저 지운다. 그 항목은 iTerm 3.6.10에서 크래시를 만든다.

`Cmd+V`는 paste라서 split에 쓰지 않는다. 그건 잘못된 선택이야.
