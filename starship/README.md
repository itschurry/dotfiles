# Starship

## 목적

[Pure 공식 프리셋](https://starship.rs/presets/pure-preset)의 두 줄 구성을 바탕으로 TokyoNight 색상과 개발 정보를 적용한 프롬프트야.
전체 경로, Git 브랜치·변경 개수, 활성 Python 가상환경을 첫 줄에 표시하고 입력 기호는 다음 줄에 둬.
대괄호·이모지·굵은 글씨·상시 시계는 사용하지 않아.

표시 예시:

```text
~/workspace/project main !2 ?1 .venv
❯
```

## 설치

macOS:

```bash
brew install starship
mkdir -p ~/.config
ln -sfn ~/dotfiles/starship/starship.toml ~/.config/starship.toml
```

Linux:

```bash
curl -sS https://starship.rs/install.sh | sh
mkdir -p ~/.config
ln -sfn ~/dotfiles/starship/starship.toml ~/.config/starship.toml
```

사용하는 셸의 초기화 파일에 아래 줄을 한 번 추가해.

```bash
# ~/.bashrc
eval "$(starship init bash)"
```

```zsh
# ~/.zshrc
eval "$(starship init zsh)"
```

## 실행

새 터미널을 열면 적용돼. Starship이 이미 초기화돼 있다면 TOML 변경은 다음 프롬프트부터 반영돼.

```bash
# Bash 초기화 설정을 추가한 경우
source ~/.bashrc
```

```zsh
# Zsh 초기화 설정을 추가한 경우
source ~/.zshrc
```

## 디렉터리 구조

```text
starship/
├── README.md
└── starship.toml
```

## 주요 설정

- `format`: 첫 줄에 SSH 사용자·호스트, 경로, Git, 가상환경. 다음 줄에 `❯` 입력 기호.
- `add_newline = true`: 명령 출력과 다음 프롬프트 사이에 빈 줄을 둬.
- `right_format = ''`: 오른쪽 프롬프트는 비워.
- 색상: 경로는 파랑, 브랜치는 회청색, 가상환경은 초록, 변경 상태는 노랑, 입력 기호는 보라. 굵게 표시하지 않아.
- `directory`: 전체 경로를 유지하고 홈 디렉터리는 `~`로 표시해. 읽기 전용 경로에는 `ro`를 붙여.
- `git_branch`: 로컬 브랜치와 이름이 다른 추적 브랜치를 표시해.
- `git_state`: rebase/merge 같은 진행 중인 Git 작업을 표시해.
- `git_status`: `!` 수정, `?` 미추적, `+` staged, `r` 이름 변경, `x` 삭제, `=` 충돌, `$` stash 뒤에 개수를 표시해. 원격과의 차이는 `↑`/`↓`로 표시해.
- Git 변경이 없으면 별도 `✓`를 표시하지 않아. 추가 `git status`를 실행하던 `custom.git_clean`도 제거했어.
- `python`: `VIRTUAL_ENV`가 있는 경우 가상환경 이름만 표시해. Python 버전과 이모지는 생략해.
- 명령 실행 시간은 표시하지 않아.
- `username`, `hostname`: 기본적으로 SSH 접속에서 표시하며 root 사용자는 강조해.
- `continuation_prompt`: 여러 줄 명령 입력 중 `..` 표시.
- 명령/디렉터리 스캔 제한 시간은 Starship 기본값을 사용해.

## Bash와 ble.sh

Bash의 프롬프트 정리는 기존 `../blesh/blerc` 설정을 사용해.
같은 경로에서 실행한 이전 프롬프트는 간략한 `>`만 남기고 오른쪽 프롬프트는 비워.

## 글꼴

`../ghostty/config`는 `Maple Mono NF`의 `Light` 스타일과 `font-thicken = false`를 사용해.
글자 크기는 14pt, 셀 높이는 +30%야. Ghostty에서 `Cmd+R`을 눌러 적용해.
