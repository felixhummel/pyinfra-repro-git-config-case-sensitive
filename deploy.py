from pathlib import Path

from pyinfra.operations import git, server

REPO = str(Path(__file__).resolve().parent / "repo")

server.shell(name="git init", commands=[f"test -d {REPO}/.git || git init -q {REPO}"])
git.config(name="camelCase key", key="core.hooksPath", value="/x", repo=REPO)
git.config(name="lowercase key", key="core.hookspath", value="/x", repo=REPO)
