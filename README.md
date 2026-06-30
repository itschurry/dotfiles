# dotfiles

## 목적

Neovim, tmux, Starship, ble.sh 기반 Bash 입력 환경, Ghostty/WezTerm 터미널 사용 흐름, VS Code, clangd 설정을 관리하는 개인 개발 환경 저장소.

## 설치

```bash
git clone <repo-url> ~/dotfiles
ln -sfn ~/dotfiles/nvim ~/.config/nvim
ln -sfn ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
mkdir -p ~/.config
ln -sfn ~/dotfiles/starship/starship.toml ~/.config/starship.toml
ln -sfn ~/dotfiles/blesh/blerc ~/.blerc
mkdir -p ~/.config/ghostty
ln -sfn ~/dotfiles/ghostty/config ~/.config/ghostty/config
```

Windows WezTerm:

```powershell
New-Item -ItemType SymbolicLink `
  -Path "$env:USERPROFILE\.wezterm.lua" `
  -Target "\\wsl.localhost\Ubuntu-24.04\home\user\dotfiles\wezterm\wezterm.lua" `
  -Force
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

Starship:

```bash
starship prompt
```

ble.sh:

```bash
source ~/.bashrc
```

Ghostty:

```bash
open -a Ghostty
```

WezTerm:

```powershell
wezterm
```

## 디렉터리 구조

```text
.
├── clangd/
│   └── clangd
├── blesh/
│   ├── README.md
│   └── blerc
├── legacy/
│   └── ros-docker/
│       ├── build.sh
│       ├── Dockerfile
│       └── run.sh
├── ghostty/
│   ├── README.md
│   └── config
├── nvim/
│   └── README.md
├── scripts/
│   └── merge_compile_commands.py
├── starship/
│   ├── README.md
│   └── starship.toml
├── tmux/
│   ├── README.md
│   └── tmux.conf
├── wezterm/
│   ├── README.md
│   └── wezterm.lua
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
- `~/.config/starship.toml`: `~/dotfiles/starship/starship.toml`으로 연결
- `~/.blerc`: `~/dotfiles/blesh/blerc`으로 연결
- `~/.config/ghostty/config`: `~/dotfiles/ghostty/config`으로 연결
- `%USERPROFILE%\.wezterm.lua`: `wezterm/wezterm.lua`로 연결
- Starship 세부 설정: `starship/README.md`
- ble.sh 세부 설정: `blesh/README.md`
- Bash 입력 개선: 문법 하이라이트, 히스토리 자동제안, 수동 자동완성 메뉴, prefix/substring 히스토리 검색
- Ghostty 세부 설정: `ghostty/README.md`
- WezTerm 세부 설정: `wezterm/README.md`
- tmux 세부 설정: `tmux/README.md`
- tmux prefix: `C-a`
- tmux status line: session/path/window/git/battery/time/prefix/copy-mode 표시
- Neovim/tmux 창 조작 suffix:
  - split 생성: `v`, `s`
  - split/pane 이동: `h`, `j`, `k`, `l`
  - split/pane 크기 조절: `C-h`, `C-j`, `C-k`, `C-l`
- tmux 안에서 `C-\`는 pane 이동에 쓰지 않고 foreground process에 그대로 전달
- Ghostty split 조작:
  - split 이동: `Alt+H/J/K/L`
  - split 생성: `Alt+V/S`
  - split 크기 조절: `Alt+Shift+H/J/K/L`
- WezTerm split 조작:
  - split 이동: `Alt+H/J/K/L`
  - split 생성: `Alt+V/S`
  - split 크기 조절: `Alt+Shift+H/J/K/L`
  - tab 이동: `Alt+Shift+[` / `Alt+Shift+]`
  - 물리 키 위치 기준 tab 이동: `Alt+Shift+LeftBracket` / `Alt+Shift+RightBracket`
  - Linux 키 해석 대응 tab 이동: `Alt+{` / `Alt+}`
  - Windows WSL 기본 실행: `wsl.exe -d Ubuntu-24.04 --cd ~`
  - 제목 표시줄 표시, resize 유지, 반투명 Acrylic 배경
  - 창 제목: `wezterm`으로 고정
  - 탭 제목: Windows는 `Ubuntu`, 그 외 플랫폼은 `wezterm`
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
