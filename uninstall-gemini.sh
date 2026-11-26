#!/usr/bin/env bash
set -euo pipefail

# ══════════════════════════════════════════════════════════════
# Gemini & Google Antigravity SEO Uninstaller
# ══════════════════════════════════════════════════════════════

main() {
    local GEMINI_CONFIG_DIR="${HOME}/.gemini/config"
    local GEMINI_SKILLS_DIR="${GEMINI_CONFIG_DIR}/skills"
    local GEMINI_PLUGIN_DIR="${GEMINI_CONFIG_DIR}/plugins/claude-seo"

    echo "→ Uninstalling SEO Toolkit for Gemini & Antigravity..."

    local removed=0

    # Remove global plugin bundle
    if [ -d "${GEMINI_PLUGIN_DIR}" ]; then
        rm -rf "${GEMINI_PLUGIN_DIR}"
        echo "  Removed: ${GEMINI_PLUGIN_DIR}"
        removed=$((removed + 1))
    fi

    # Remove global seo-* skills
    shopt -s nullglob
    for skill_path in "${GEMINI_SKILLS_DIR}"/seo*; do
        if [ -d "${skill_path}" ]; then
            rm -rf "${skill_path}"
            echo "  Removed: ${skill_path}"
            removed=$((removed + 1))
        fi
    done
    shopt -u nullglob

    # Clean local .agents/ if requested
    if [ "${1:-}" = "--local" ] && [ -d ".agents" ]; then
        rm -rf .agents/skills/seo*
        echo "  Cleaned local .agents/skills/seo*"
        removed=$((removed + 1))
    fi

    if [ "${removed}" -eq 0 ]; then
        echo "  Nothing to remove. Toolkit does not appear to be installed in ~/.gemini/config."
        return 0
    fi

    echo "✓ SEO Toolkit successfully uninstalled from Gemini/Antigravity configuration."
}

main "$@"
