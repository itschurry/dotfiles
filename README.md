# dotfiles

## 목적

Neovim, tmux, VS Code, clangd 설정을 관리하는 개인 개발 환경 저장소.

## 설치

```bash
git clone <repo-url> ~/dotfiles
ln -sfn ~/dotfiles/nvim ~/.config/nvim
ln -sfn ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
```

## 실행

Neovim:

```bash
nvim
```

tmux:

```bash
tmux
```

## 디렉터리 구조

```text
.
├── clangd/
│   └── clangd
├── legacy/
│   └── ros-docker/
│       ├── build.sh
│       ├── Dockerfile
│       └── run.sh
├── nvim/
│   └── README.md
├── scripts/
│   └── merge_compile_commands.py
├── tmux/
│   ├── README.md
│   └── tmux.conf
└── vscode/
    ├── c_cpp_properties.json
    ├── launch.json
    ├── settings.json
    ├── sftp.json
    └── tasks.json
```

## 주요 설정

- `~/.config/nvim`: `~/dotfiles/nvim`으로 연결
- `~/.tmux.conf`: `~/dotfiles/tmux/tmux.conf`으로 연결
- tmux 세부 설정: `tmux/README.md`
- tmux status line: 기본 스타일에 시간 표시
- `legacy/ros-docker`: 특정 ROS Docker 환경용 예전 스크립트

## 저장소 이름

권장 GitHub 저장소 이름:

```text
dotfiles
```

GitHub에서 저장소 이름을 `nvim-config`에서 `dotfiles`로 바꾼 뒤 remote를 갱신해.

```bash
git remote set-url origin git@github.com:itschurry/dotfiles.git
```
