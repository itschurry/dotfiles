# nvim-config

## 목적

Neovim 설정과 tmux 설정을 관리하는 개인 개발 환경 설정 저장소.

## 설치

```bash
git clone <repo-url> ~/nvim-config
ln -sfn ~/nvim-config/nvim ~/.config/nvim
ln -sfn ~/nvim-config/tmux_config/tmux.conf ~/.tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
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

tmux 플러그인 설치:

```text
prefix + I
```

tmux 설정 리로드:

```text
prefix + r
```

## 디렉터리 구조

```text
.
├── nvim/
│   └── README.md
└── tmux_config/
    └── tmux.conf
```

## 주요 설정

- `~/.config/nvim`: `~/nvim-config/nvim`으로 연결
- `~/.tmux.conf`: `~/nvim-config/tmux_config/tmux.conf`으로 연결
- tmux prefix: `C-b`
- tmux 플러그인 관리자: TPM
- tmux 플러그인: `tmux-resurrect`, `tmux-continuum`, `tmux-yank`
- tmux 테마: 별도 테마 없음
- tmux status line: 기본 스타일에 시간 표시
