# Starship dotfiles

## Purpose

Bash에서 쓰는 개발용 Starship 프롬프트 설정이다. 장식은 줄이고 경로, Git 상태, 주요 언어 런타임, Docker, Kubernetes, 실행 시간, 종료 코드만 깔끔하게 보이게 한다.

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

- `format`: 왼쪽 프롬프트에 경로, Git, Docker, Kubernetes, 주요 언어 런타임, 실행 시간을 표시
- `right_format`: 오른쪽 프롬프트에 백그라운드 작업, 종료 코드, 현재 시간 표시
- `command_timeout`: Starship 모듈 명령 제한 시간 750ms
- `scan_timeout`: 디렉터리 스캔 제한 시간 30ms
- `directory.truncation_length`: 경로 최대 4단계 표시
- `git_status`: 변경 상태를 짧은 ASCII 기호와 개수로 표시
- `package.disabled`: 패키지 버전 표시는 꺼둠
- `aws`, `gcloud`, `azure`: 클라우드 컨텍스트 표시는 꺼둠

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
