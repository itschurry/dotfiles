# Starship dotfiles

## Purpose

Bash에서 쓰는 개발용 Starship 프롬프트 설정이다. Bracketed Segments preset을 기반으로 쓰되, 왼쪽은 경로와 Git만 두고 언어 런타임, Docker, Kubernetes, 실행 시간, 종료 코드, 시간은 오른쪽 프롬프트로 보낸다.
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
- `tokyo-night colors`: 경로, Git, 런타임, 상태, 시간에 Tokyo Night 계열 색상만 적용
- `format`: 왼쪽 프롬프트에 경로와 Git 상태만 표시
- `right_format`: 오른쪽 프롬프트에 언어 런타임, Docker, Kubernetes, 실행 시간, 백그라운드 작업, 종료 코드, 현재 시간 표시
- `continuation_prompt`: 여러 줄 명령 입력 중 `..` 표시
- `directory.truncation_length`: 경로를 줄이지 않고 풀 경로로 표시
- `command_timeout`: Starship 모듈 명령 제한 시간 750ms
- `scan_timeout`: 디렉터리 스캔 제한 시간 30ms
- `git_status`: 변경 상태를 bracketed preset 형식으로 표시
- `package.disabled`: 패키지 버전 표시는 꺼둠
- `aws`, `gcloud`, `azure`: 클라우드 컨텍스트 표시는 꺼둠

## Advanced behavior

Bash에서 오른쪽 프롬프트와 이전 프롬프트 정리는 `ble.sh`가 담당한다. 설정은 `../blesh/blerc`에 있다.

- `prompt_ps1_transient=same-dir:trim`: 같은 디렉터리에서 실행한 이전 프롬프트는 마지막 줄만 남김
- `prompt_ps1_final`: 이전 프롬프트 왼쪽은 Starship character만 남김
- `prompt_rps1_final`: 이전 프롬프트 오른쪽은 종료 코드와 시간만 남김

## Options

Kubernetes 컨텍스트가 시끄러우면 아래 값만 바꿔.

```toml
[kubernetes]
disabled = true
```

클라우드 컨텍스트가 필요하면 해당 모듈을 켜.

```toml
[aws]
disabled = false

[gcloud]
disabled = false

[azure]
disabled = false
```
