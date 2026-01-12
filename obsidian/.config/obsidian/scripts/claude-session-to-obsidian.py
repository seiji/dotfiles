#!/usr/bin/env python3
"""
Claude Code session logs to Obsidian Daily Notes converter

Usage:
    claude-session-to-obsidian.py [--date YYYY-MM-DD] [--dry-run]
"""

import argparse
import json
import os
import socket
import sys
from datetime import datetime, timedelta
from pathlib import Path
from typing import Iterator, Optional

CLAUDE_PROJECTS_DIR = Path.home() / ".config/claude/projects"
OBSIDIAN_VAULT_DIR = Path(
    os.environ.get("OBSIDIAN_CLAUDE_DIR", "~/obsidian/claude")
).expanduser()
DATE_FORMAT = "%Y-%m-%d"


def parse_jsonl(filepath: Path) -> Iterator[dict]:
    """Parse JSONL file line by line"""
    with open(filepath, "r", encoding="utf-8") as f:
        for line in f:
            line = line.strip()
            if not line:
                continue
            try:
                yield json.loads(line)
            except json.JSONDecodeError:
                continue


def extract_text_content(content) -> Optional[str]:
    """Extract text from message.content"""
    if isinstance(content, str):
        if content.startswith("<local-command") or content.startswith("<command-name>"):
            return None
        return content
    elif isinstance(content, list):
        texts = []
        for item in content:
            if isinstance(item, dict) and item.get("type") == "text":
                text = item.get("text", "")
                if text:
                    texts.append(text)
        return "\n".join(texts) if texts else None
    return None


def extract_project_name(cwd: str) -> str:
    """Extract project name from working directory"""
    if not cwd:
        return "unknown"
    return Path(cwd).name


def collect_messages(filepath: Path, target_date: str) -> list[dict]:
    """Collect messages with metadata for target date"""
    messages = []

    for record in parse_jsonl(filepath):
        ts = record.get("timestamp", "")
        if not ts.startswith(target_date):
            continue

        record_type = record.get("type", "")
        if record_type not in ("user", "assistant"):
            continue

        if record.get("isMeta"):
            continue

        msg = record.get("message", {})
        content = extract_text_content(msg.get("content"))
        if not content:
            continue

        messages.append({
            "timestamp": ts,
            "role": msg.get("role", ""),
            "content": content,
            "project": extract_project_name(record.get("cwd", "")),
            "slug": record.get("slug", "unknown"),
        })

    return messages


def find_all_session_files() -> Iterator[Path]:
    """Find all session JSONL files"""
    if not CLAUDE_PROJECTS_DIR.exists():
        return

    for project_dir in CLAUDE_PROJECTS_DIR.iterdir():
        if not project_dir.is_dir() or project_dir.name.startswith("."):
            continue
        for jsonl_file in project_dir.glob("*.jsonl"):
            yield jsonl_file


def generate_daily_note(target_date: str) -> str:
    """Generate Daily Note content for target date"""
    all_messages = []

    for session_file in find_all_session_files():
        messages = collect_messages(session_file, target_date)
        all_messages.extend(messages)

    if not all_messages:
        return ""

    all_messages.sort(key=lambda m: m["timestamp"])

    content = f"# Claude Sessions - {target_date}\n\n"

    prev_project = None
    for msg in all_messages:
        project = msg["project"]
        if project != prev_project:
            content += f"\n---\n### {project}\n\n"
            prev_project = project

        time_str = msg["timestamp"][11:16] if len(msg["timestamp"]) >= 16 else ""
        role = "User" if msg["role"] == "user" else "Assistant"
        content += f"**[{time_str}] {role}:**\n{msg['content']}\n\n"

    return content


def main():
    parser = argparse.ArgumentParser(
        description="Claude sessions to Obsidian Daily Notes"
    )
    parser.add_argument("--date", help="Target date (YYYY-MM-DD), default: yesterday")
    parser.add_argument(
        "--dry-run", action="store_true", help="Print output without writing"
    )
    args = parser.parse_args()

    if args.date:
        target_date = args.date
    else:
        yesterday = datetime.now() - timedelta(days=1)
        target_date = yesterday.strftime(DATE_FORMAT)

    content = generate_daily_note(target_date)

    if not content:
        print(f"No sessions found for {target_date}", file=sys.stderr)
        return 0

    if args.dry_run:
        print(content)
        return 0

    OBSIDIAN_VAULT_DIR.mkdir(parents=True, exist_ok=True)

    hostname = socket.gethostname().split(".")[0]
    output_file = OBSIDIAN_VAULT_DIR / f"{target_date}-{hostname}.md"

    mode = "a" if output_file.exists() else "w"
    with open(output_file, mode, encoding="utf-8") as f:
        if mode == "a":
            f.write("\n---\n\n")
        f.write(content)

    print(f"Written to {output_file}", file=sys.stderr)
    return 0


if __name__ == "__main__":
    sys.exit(main())
