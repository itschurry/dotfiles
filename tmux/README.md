# tmux

## 목적

개발용 tmux 설정. Ghostty 같은 가벼운 터미널에서 tmux를 주 작업 UI로 쓰기 좋게 status line과 pane/window 키 바인딩을 관리한다.

## 설치

```bash
ln -sfn ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

## 실행

```bash
tmux
```

설정 리로드:

```text
prefix + r
```

플러그인 설치:

```text
prefix + I
```

## 디렉터리 구조

```text
tmux/
├── README.md
└── tmux.conf
```

## 주요 옵션

- prefix: `C-b`
- 터미널: `tmux-256color`
- 마우스: 켜짐
- window index: `0`부터 시작
- pane index: `0`부터 시작
- status line: 하단, session/path/window/git/battery/time/prefix/copy-mode 표시
- copy mode: vi key
- 테마 플러그인: 없음
- 색상: 기본 배경, 낮은 대비 status line, 초록색 active window
- pane 구분선: 단일 선, 낮은 대비 색상

## Status line

왼쪽:

```text
session PREFIX COPY cwd
```

오른쪽:

```text
git-branch battery time date
```

- `PREFIX`: prefix 입력 중일 때만 표시
- `COPY`: copy mode일 때만 표시
- `git-branch`: 현재 pane 경로 기준 Git branch
- `battery`: macOS `pmset` 기준 배터리 퍼센트

## 키 바인딩

- Neovim도 같은 suffix를 쓴다. tmux는 `prefix`, Neovim은 `,`만 다르다.
- `prefix + r`: 설정 리로드
- `prefix + p`: 현재 pane 종료
- `prefix + x`: 다음 window
- `prefix + z`: 이전 window
- `prefix + v`: 좌우 split
- `prefix + s`: 상하 split
- `prefix + h/j/k/l`: pane 이동
- `prefix + C-h/C-j/C-k/C-l`: pane 크기 조절
- `prefix + u`: 화면의 URL을 fzf로 선택해서 열기
- `M-h/M-j/M-k/M-l`: Neovim split과 tmux pane 사이 이동
- `C-h/C-j/C-k/C-l`: 셸/터미널 기본 동작

## 플러그인

- `tmux-plugins/tpm`
- `tmux-plugins/tmux-resurrect`
- `tmux-plugins/tmux-continuum`
- `tmux-plugins/tmux-yank`
- `christoomey/vim-tmux-navigator`
- `tmux-plugins/tmux-copycat`
- `wfxr/tmux-fzf-url`

`tmux-yank`의 copy binding은 `xclip`을 사용한다.

```bash
sudo apt install xclip
```

`tmux-fzf-url`은 `fzf`를 사용한다.

```bash
sudo apt install fzf
```
