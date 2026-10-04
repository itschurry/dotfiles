# Starship dotfiles

## Purpose

Bash에서 쓰는 개발용 Starship 프롬프트 설정이다. Bracketed Segments preset을 기반으로 쓰되, 왼쪽은 경로, 활성 Python 가상환경 이름, Git을 두고 실행 시간, 백그라운드 작업, 종료 코드, 시간만 오른쪽 프롬프트로 보낸다.
입력 기호와 읽기 전용 경로 색상은 Tokyo Night 계열을 사용한다. 주석 처리된 모듈 색상은 적용되지 않고 Starship 기본 색상을 사용한다.

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
- `character`, `directory.read_only_style`: 입력 기호와 읽기 전용 경로에 Tokyo Night 계열 색상 적용
- `format`: 왼쪽 프롬프트에 경로, 활성 Python 가상환경 이름, Git 브랜치, Git clean/dirty 상태 표시
- `python`: `VIRTUAL_ENV`가 설정되면 `[🐍 환경이름]` 표시. Python 버전은 표시하지 않고 파일·폴더 기반 프로젝트 감지는 비움
- `right_format`: 오른쪽 프롬프트에 실행 시간, 백그라운드 작업, 종료 코드, 현재 시간 표시
- `continuation_prompt`: 여러 줄 명령 입력 중 `..` 표시
- `directory.truncation_length`: 경로를 줄이지 않고 풀 경로로 표시
- `command_timeout`: 별도 지정 없이 기본 명령 제한 시간 500ms 사용
- `scan_timeout`: 별도 지정 없이 기본 디렉터리 스캔 제한 시간 30ms 사용
- `git_branch`: 로컬 브랜치 표시, 추적 브랜치 이름이 다르면 함께 표시
- `custom.git_clean`: Git 저장소에서만 상태를 검사하고, 깨끗하면 `✓` 표시
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
right_format = "$docker_context$cmd_duration$jobs$status$time"
```

## 공식 설정 검토

[Starship 공식 설정 문서](https://starship.rs/config/) 기준으로 확인한 내용이다.

- `format`과 `right_format`에 없는 모듈의 프리셋 설정은 현재 사용하지 않는다. 언어 런타임, 클라우드, 패키지 등의 설정이 남아 있지만 해당 모듈을 프롬프트에 추가하기 전까지 실행되지 않는다.
- `command_timeout = 500`은 기본값과 같아서 제거했다. `scan_timeout = 10`도 제거해서 기본값 30ms를 사용한다.
- `$python`의 기본 `$virtualenv` 기능으로 활성 가상환경을 표시한다. `detect_extensions`, `detect_files`, `detect_folders`는 비우고 `detect_env_vars = ['VIRTUAL_ENV']`만 사용한다. 설치된 Starship 1.26.0은 감지 목록을 비워도 내부 디렉터리 스캔을 먼저 수행하므로 스캔 자체가 비활성화되지는 않는다.
- `custom.git_clean`은 `git status --porcelain`을 추가 실행한다. `git_status`와 상태 검사가 겹치지만 작업 폴더가 깨끗할 때 `✓`를 표시하는 현재 동작을 유지한다.
- 기본 `git_status.up_to_date`는 원격 추적 브랜치와의 동기화 상태다. 미커밋 변경이 없는 상태와 의미가 달라 `custom.git_clean`의 대체 설정으로 쓰지 않는다.
- `git_status.up_to_date = ''`는 기본값과 같은 명시적 설정이다. 동기화 표시를 비워두려는 의도를 보여주므로 유지한다.
- 오른쪽 프롬프트는 Starship의 `right_format`을 사용한다. Bash에서 이를 표시하고 이전 프롬프트를 정리하는 ble.sh 설정은 공식 Bash 연동 방식이며 별도 프롬프트 구현이 아니다.
- Git 상태별 개수, 전체 경로 표시, 대괄호 형식은 기본 옵션을 조합한 사용자 표시 설정이다. 불필요한 기능 재구현이 아니다.
