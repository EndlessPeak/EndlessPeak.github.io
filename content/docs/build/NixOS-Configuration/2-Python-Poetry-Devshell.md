---
title: Python Development on NixOS
date: 2024-06-11 22:00:00
authors:
  - EndlessPeak
toc: true
hidden: false
draft: false
weight: 2
description: 本文记录了在NixOS上如何进行python开发环境的构建。
---

## Discourse NixOS {#discourse-nixos}

该部分文章尚未完成。
Impure Python Poetry devShell

```nix
(pkgs.poetry.override { python = pkgs.python39; })
```

```shell
poetry run python -c "import matplotlib"
Traceback (most recent call last):
  File "<string>", line 1, in <module>
ModuleNotFoundError: No module named 'matplotlib'
```

```shell
python -m site
sys.path = [
    '/home/asymmetric/code/foo',
    '/nix/store/6qk2ybm2yx2dxmx9h4dikr1shjhhbpfr-python3-3.10.11/lib/python310.zip',
    '/nix/store/6qk2ybm2yx2dxmx9h4dikr1shjhhbpfr-python3-3.10.11/lib/python3.10',
    '/nix/store/6qk2ybm2yx2dxmx9h4dikr1shjhhbpfr-python3-3.10.11/lib/python3.10/lib-dynload',
    '/nix/store/6qk2ybm2yx2dxmx9h4dikr1shjhhbpfr-python3-3.10.11/lib/python3.10/site-packages',
    '/nix/store/qyy1khnfvvv6m57gkh8qijj45v3h78jy-python3-3.10.11-env/lib/python3.10/site-packages',
]
USER_BASE: '/home/asymmetric/.local' (exists)
USER_SITE: '/home/asymmetric/.local/lib/python3.10/site-packages' (doesn't exist)
ENABLE_USER_SITE: False
```

```shell
poetry run python -m site
sys.path = [
    '/home/asymmetric/code/foo',
    '/nix/store/6qk2ybm2yx2dxmx9h4dikr1shjhhbpfr-python3-3.10.11/lib/python310.zip',
    '/nix/store/6qk2ybm2yx2dxmx9h4dikr1shjhhbpfr-python3-3.10.11/lib/python3.10',
    '/nix/store/6qk2ybm2yx2dxmx9h4dikr1shjhhbpfr-python3-3.10.11/lib/python3.10/lib-dynload',
    '/home/asymmetric/code/foo/.venv/lib/python3.10/site-packages',
    '/nix/store/6qk2ybm2yx2dxmx9h4dikr1shjhhbpfr-python3-3.10.11/lib/python3.10/site-packages',
]
USER_BASE: '/home/asymmetric/.local' (exists)
USER_SITE: '/home/asymmetric/.local/lib/python3.10/site-packages' (doesn't exist)
ENABLE_USER_SITE: False
```

```shell
[asymmetric@tachikoma:~/code/foo]$ poetry run python
Python 3.10.11 (main, Apr  4 2023, 22:10:32) [GCC 12.3.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import site
>>> site.addsitedir("/nix/store/qyy1khnfvvv6m57gkh8qijj45v3h78jy-python3-3.10.11-env/lib/python3.10/site-packages")
>>> import matplotlib
>>> exit()
```

```shell
[asymmetric@tachikoma:~/code/foo]$ poetry env info
Virtualenv
Python:         3.10.11
Implementation: CPython
Path:           /home/asymmetric/.cache/pypoetry/virtualenvs/foo-jKhUbUE3-py3.10
Executable:     /home/asymmetric/.cache/pypoetry/virtualenvs/foo-jKhUbUE3-py3.10/bin/python
Valid:          True

System
Platform:   linux
OS:         posix
Python:     3.10.11
Path:       /nix/store/6qk2ybm2yx2dxmx9h4dikr1shjhhbpfr-python3-3.10.11
Executable: /nix/store/6qk2ybm2yx2dxmx9h4dikr1shjhhbpfr-python3-3.10.11/bin/python3.10
```

```shell
[asymmetric@tachikoma:~/code/foo]$ poetry env use -vv  /nix/store/qyy1khnfvvv6m57gkh8qijj45v3h78jy-python3-3.10.11-env/bin/python
Trying to detect current active python executable as specified in the config.
Found: /nix/store/6qk2ybm2yx2dxmx9h4dikr1shjhhbpfr-python3-3.10.11/bin/python
Using virtualenv: /home/asymmetric/.cache/pypoetry/virtualenvs/foo-jKhUbUE3-py3.10

[asymmetric@tachikoma:~/code/foo]$ poetry env info

Virtualenv
Python:         3.10.11
Implementation: CPython
Path:           /home/asymmetric/.cache/pypoetry/virtualenvs/foo-jKhUbUE3-py3.10
Executable:     /home/asymmetric/.cache/pypoetry/virtualenvs/foo-jKhUbUE3-py3.10/bin/python
Valid:          True

System
Platform:   linux
OS:         posix
Python:     3.10.11
Path:       /nix/store/6qk2ybm2yx2dxmx9h4dikr1shjhhbpfr-python3-3.10.11
Executable: /nix/store/6qk2ybm2yx2dxmx9h4dikr1shjhhbpfr-python3-3.10.11/bin/python3.10
```

```nix
packages = with pkgs;[
    python311Packages.tkinter
    (poetry.overrideAttrs (oldAttrs:{
    # 禁用 --unset PYTHONPATH
    # 因为我有外部包(tkinter)需要使用
    makeWrapperArgs = [ ];
    }))
];
```
