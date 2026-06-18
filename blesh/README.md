# ble.sh dotfiles

## Purpose

Bash에서 `ble.sh`를 조용하게 쓰기 위한 설정이다. 문법 하이라이트와 파일명 하이라이트는 끄고, 히스토리 기반 자동제안만 흐린 회색으로 표시한다.

## Installation

`ble.sh`가 이미 설치되어 있어야 한다.

```bash
git clone --recursive https://github.com/akinomyoga/ble.sh.git /tmp/ble.sh
make -C /tmp/ble.sh
make -C /tmp/ble.sh install PREFIX=~/.local
```

`~/.bashrc` 끝에 추가해.

```bash
source ~/.local/share/blesh/ble.sh
```

이 저장소 설정을 `ble.sh` 기본 설정 위치에 연결해.

```bash
ln -sfn ~/dotfiles/blesh/blerc ~/.blerc
```

## Run

```bash
source ~/.bashrc
```

현재 셸에서 바로 다시 읽으려면 새 터미널을 여는 게 제일 깔끔하다.

## Directory structure

```text
.
├── README.md
└── blerc
```

## Main options

- `highlight_syntax`: 명령어 문법 하이라이트 끔
- `highlight_filename`: 파일명 하이라이트 끔
- `highlight_variable`: 변수 타입 하이라이트 끔
- `complete_auto_delay`: 자동제안 표시 지연 시간 200ms
- `complete_ambiguous`: 애매한 자동완성 끔
- `complete_menu_complete`: 탭 메뉴 완성 끔
- `complete_menu_filter`: 메뉴 필터링 끔
- `auto_complete`: 자동제안은 배경 없이 흐린 회색으로 표시
