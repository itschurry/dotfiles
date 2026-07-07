# Starship dotfiles

## Purpose

Bash에서 쓰는 개발용 Starship 프롬프트 설정이다. Bracketed Segments preset을 기반으로 쓰되, 왼쪽은 경로와 Git만 두고 실행 시간, 백그라운드 작업, 종료 코드, 시간만 오른쪽 프롬프트로 보낸다.
색상은 Tokyo Night 계열만 적용하고, Tokyo Night preset의 Powerline 레이아웃은 쓰지 않는다.

## Installation

```bash
curl -sS https://starship.rs/install.sh | sh
```

Bash 초기화 파일에 추가해.

```bash
echo 'eval "$(starship init bash)"' >> ~/.bashrc
```

이 저장소 설정을 기본 설정 위치에 연결해.

```bash
mkdir -p ~/.config
ln -sf "$PWD/starship.toml" ~/.config/starship.toml
```

## Run

```bash
source ~/.bashrc
```

설정 파일만 직접 지정해서 테스트하려면 이렇게 해.

```bash
STARSHIP_CONFIG="$PWD/starship.toml" starship prompt
```

## Directory structure

```text
.
├── README.md
└── starship.toml
```

## Main configuration

- `bracketed-segments`: Starship 기본 문구 대신 각 모듈을 `[...]` 형태로 표시
- `tokyo-night colors`: 경로, Git, 상태, 시간에 Tokyo Night 계열 색상만 적용
- `format`: 왼쪽 프롬프트에 경로, Git 브랜치, Git clean/dirty 상태만 표시
- `right_format`: 오른쪽 프롬프트에 실행 시간, 백그라운드 작업, 종료 코드, 현재 시간 표시
- `continuation_prompt`: 여러 줄 명령 입력 중 `..` 표시
- `directory.truncation_length`: 경로를 줄이지 않고 풀 경로로 표시
- `command_timeout`: Starship 모듈 명령 제한 시간 500ms
- `scan_timeout`: 디렉터리 스캔 제한 시간 10ms
- `git_branch`: 로컬 브랜치와 remote 브랜치를 같이 표시
- `custom.git_clean`: Git 저장소가 깨끗하면 `✓` 표시
- `git_status`: staged, modified, untracked, deleted, renamed, stashed, ahead/behind 상태를 개수와 함께 표시
- `package.disabled`: 패키지 버전 표시는 꺼둠
- `aws`, `gcloud`, `azure`: 클라우드 컨텍스트 표시는 꺼둠

## Advanced behavior

Bash에서 오른쪽 프롬프트와 이전 프롬프트 정리는 `ble.sh`가 담당한다. 설정은 `../blesh/blerc`에 있다. 이전 프롬프트 정리 단계에서는 `starship` 프로세스를 새로 띄우지 않는다.

- `prompt_ps1_transient=same-dir:trim`: 같은 디렉터리에서 실행한 이전 프롬프트는 마지막 줄만 남김
- `prompt_ps1_final`: 이전 프롬프트 왼쪽은 고정 `>`만 남김
- `prompt_rps1_final`: 이전 프롬프트 오른쪽은 비움

## Options

오른쪽 프롬프트에 언어 런타임이나 컨테이너 컨텍스트가 필요하면 `right_format`에 필요한 모듈만 직접 추가해.

```toml
right_format = "$python$docker_context$cmd_duration$jobs$status$time"
```
