# dotfiles

## 목적

Neovim, tmux, iTerm, VS Code, clangd 설정을 관리하는 개인 개발 환경 저장소.

## 설치

```bash
git clone <repo-url> ~/dotfiles
ln -sfn ~/dotfiles/nvim ~/.config/nvim
ln -sfn ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
chmod +x ~/dotfiles/iterm/apply-keymaps.sh
~/dotfiles/iterm/apply-keymaps.sh
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

iTerm:

```bash
open -a iTerm
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
├── iterm/
│   ├── keymaps/
│   │   └── my-keymap.plist
│   ├── README.md
│   └── apply-keymaps.sh
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
- iTerm 세부 설정: `iterm/README.md`
- tmux 세부 설정: `tmux/README.md`
- tmux status line: 기본 스타일에 시간 표시
- Neovim/tmux 창 조작 suffix:
  - split 생성: `v`, `s`
  - split/pane 이동: `h`, `j`, `k`, `l`
  - split/pane 크기 조절: `C-h`, `C-j`, `C-k`, `C-l`
- iTerm pane 조작:
  - pane 이동: `Cmd+H/J/K/L`
  - split 생성: `Cmd+Shift+V/S`
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
