# ble.sh dotfiles

## Purpose

Bash에서 `ble.sh`로 zsh에 가까운 입력 경험을 쓰기 위한 설정이다. 문법/파일/변수 하이라이트, 히스토리 자동제안, 자동완성 메뉴, 히스토리 검색 키를 켠다. Starship 오른쪽 프롬프트와 transient prompt도 여기서 제어한다.

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

현재 셸에서 바로 다시 읽으려면 새 터미널을 열어.

## Directory structure

```text
.
├── README.md
└── blerc
```

## Main options

- `highlight_syntax`: 명령어 문법 하이라이트 켬
- `highlight_filename`: 파일명 하이라이트 켬
- `highlight_variable`: 변수 타입 하이라이트 켬
- `complete_auto_delay`: 자동제안 표시 지연 시간 150ms
- `complete_auto_complete`: 입력 중 자동완성 후보 표시 켬
- `complete_auto_history`: 히스토리 기반 자동제안 켬
- `complete_auto_menu`: 입력 후 250ms 뒤 자동완성 메뉴 표시
- `complete_ambiguous`: 애매한 후보도 메뉴로 표시
- `complete_menu_complete`: 메뉴에서 선택한 후보를 바로 삽입
- `complete_menu_filter`: 입력값으로 메뉴 후보 필터링
- `complete_menu_maxlines`: 자동완성 메뉴 최대 12줄 표시
- `prompt_ps1_transient`: 같은 디렉터리에서 실행한 이전 Starship 프롬프트를 짧게 정리
- `prompt_ps1_final`: 이전 프롬프트 왼쪽에는 Starship character만 표시
- `prompt_rps1_final`: 이전 프롬프트 오른쪽에는 종료 코드와 시간만 표시
- `auto_complete`: 자동제안은 배경 없이 흐린 회색으로 표시

## Key bindings

- `C-r`: 히스토리 역방향 검색
- `C-p` / `C-n`: 현재 입력 prefix 기준 히스토리 이동
- `M-p` / `M-n`: 현재 입력 substring 기준 히스토리 이동
- `Tab`: 자동완성 메뉴 열기/선택
- `Shift-Tab`: 자동완성 메뉴 역방향 선택
