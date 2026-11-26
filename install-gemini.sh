#!/usr/bin/env bash
set -euo pipefail

# ══════════════════════════════════════════════════════════════
# Gemini & Google Antigravity SEO Installer
# ══════════════════════════════════════════════════════════════
# Installs and configures Claude/Gemini SEO for Google Gemini CLI
# and Google Antigravity IDE / Agents.
# ══════════════════════════════════════════════════════════════

main() {
    local MODE="global"
    local REPO_URL="https://github.com/kitesurf/claude-seo-eu"
    local REPO_TAG="${CLAUDE_SEO_TAG:-v2.6.3}"
    local GEMINI_CONFIG_DIR="${HOME}/.gemini/config"
    local GEMINI_SKILLS_DIR="${GEMINI_CONFIG_DIR}/skills"
    local GEMINI_PLUGIN_DIR="${GEMINI_CONFIG_DIR}/plugins/claude-seo"
    local SCRIPT_DIR
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --local)
                MODE="local"
                shift
                ;;
            --global)
                MODE="global"
                shift
                ;;
            --help|-h)
                echo "Usage: ./install-gemini.sh [--local | --global]"
                echo "  --global (default): Install to ~/.gemini/config/ for all workspaces"
                echo "  --local:            Configure current project workspace (.agents/ & local .venv)"
                exit 0
                ;;
            *)
                echo "Unknown option: $1"
                echo "Usage: ./install-gemini.sh [--local | --global]"
                exit 1
                ;;
        esac
    done

    echo "════════════════════════════════════════════════════════"
    echo "║   Gemini & Antigravity SEO Toolkit - Installer       ║"
    echo "║   Google Gemini & Antigravity Skills Setup           ║"
    echo "════════════════════════════════════════════════════════"
    echo ""
    echo "→ Installation mode: ${MODE}"
    echo ""

    # Check prerequisites
    command -v git >/dev/null 2>&1 || { echo "✗ Git is required but not installed."; exit 1; }
    
    # Check Python 3.10+
    local py_found=0
    for cmd in python3 python py; do
        if command -v "${cmd}" >/dev/null 2>&1; then
            if "${cmd}" -c 'import sys; exit(0 if sys.version_info >= (3, 10) else 1)' >/dev/null 2>&1; then
                py_found=1
                break
            fi
        fi
    done

    if [ "${py_found}" -eq 0 ]; then
        echo "✗ Python 3.10 or newer is required." >&2
        exit 1
    fi

    # Determine source directory
    local SOURCE_DIR=""
    local TEMP_DIR=""
    if [ -f "${SCRIPT_DIR}/skills/seo/SKILL.md" ] && ([ -f "${SCRIPT_DIR}/scripts/claude-seo" ] || [ -f "${SCRIPT_DIR}/bin/claude-seo" ]); then
        SOURCE_DIR="${SCRIPT_DIR}"
        echo "→ Using local repository at ${SOURCE_DIR}"
    else
        TEMP_DIR=$(mktemp -d)
        cleanup() { rm -rf -- "${TEMP_DIR}"; }
        trap cleanup EXIT
        echo "↓ Downloading SEO Toolkit (${REPO_TAG})..."
        git clone --depth 1 --branch "${REPO_TAG}" "${REPO_URL}" "${TEMP_DIR}/claude-seo" 2>/dev/null
        SOURCE_DIR="${TEMP_DIR}/claude-seo"
    fi

    local launcher_subpath="scripts/claude-seo"
    if [ ! -f "${SOURCE_DIR}/${launcher_subpath}" ] && [ -f "${SOURCE_DIR}/bin/claude-seo" ]; then
        launcher_subpath="bin/claude-seo"
    fi

    if [ "${MODE}" = "local" ]; then
        # Local workspace setup (.agents/)
        echo "→ Setting up project workspace (.agents/)..."
        local workspace_agents="${SCRIPT_DIR}/.agents"
        mkdir -p "${workspace_agents}/skills"
        mkdir -p "${workspace_agents}/rules"

        if [ "${SOURCE_DIR}" != "${SCRIPT_DIR}" ]; then
            for skill_dir in "${SOURCE_DIR}/skills"/*/; do
                [ -d "${skill_dir}" ] || continue
                skill_name=$(basename "${skill_dir}")
                target="${workspace_agents}/skills/${skill_name}"
                rm -rf "${target}"
                mkdir -p "${target}"
                cp -r "${skill_dir}"* "${target}/"
            done

            if [ -d "${SOURCE_DIR}/extensions" ]; then
                for ext_dir in "${SOURCE_DIR}/extensions"/*/; do
                    [ -d "${ext_dir}" ] || continue
                    if [ -d "${ext_dir}skills" ]; then
                        for ext_skill in "${ext_dir}skills"/*/; do
                            [ -d "${ext_skill}" ] || continue
                            ext_skill_name=$(basename "${ext_skill}")
                            target="${workspace_agents}/skills/${ext_skill_name}"
                            rm -rf "${target}"
                            mkdir -p "${target}"
                            cp -r "${ext_skill}"* "${target}/"
                        done
                    fi
                done
            fi

            if [ -f "${SOURCE_DIR}/.agents/mcp_config.json" ]; then
                cp "${SOURCE_DIR}/.agents/mcp_config.json" "${workspace_agents}/mcp_config.json"
            fi
        fi

        echo "→ Initializing Python runtime..."
        chmod +x "${SCRIPT_DIR}/${launcher_subpath}"
        "${SCRIPT_DIR}/${launcher_subpath}" setup

    else
        # Global installation into ~/.gemini/config/
        echo "→ Installing globally to ${GEMINI_CONFIG_DIR}..."
        mkdir -p "${GEMINI_SKILLS_DIR}"
        mkdir -p "${GEMINI_PLUGIN_DIR}"

        # Copy plugin files
        echo "  → Copying plugin bundle..."
        cp -r "${SOURCE_DIR}/skills" "${GEMINI_PLUGIN_DIR}/"
        [ -d "${SOURCE_DIR}/agents" ] && cp -r "${SOURCE_DIR}/agents" "${GEMINI_PLUGIN_DIR}/"
        [ -d "${SOURCE_DIR}/scripts" ] && cp -r "${SOURCE_DIR}/scripts" "${GEMINI_PLUGIN_DIR}/"
        [ -d "${SOURCE_DIR}/schema" ] && cp -r "${SOURCE_DIR}/schema" "${GEMINI_PLUGIN_DIR}/"
        [ -d "${SOURCE_DIR}/data" ] && cp -r "${SOURCE_DIR}/data" "${GEMINI_PLUGIN_DIR}/"
        [ -d "${SOURCE_DIR}/pdf" ] && cp -r "${SOURCE_DIR}/pdf" "${GEMINI_PLUGIN_DIR}/"
        [ -d "${SOURCE_DIR}/hooks" ] && cp -r "${SOURCE_DIR}/hooks" "${GEMINI_PLUGIN_DIR}/"
        [ -d "${SOURCE_DIR}/bin" ] && cp -r "${SOURCE_DIR}/bin" "${GEMINI_PLUGIN_DIR}/"
        [ -d "${SOURCE_DIR}/extensions" ] && cp -r "${SOURCE_DIR}/extensions" "${GEMINI_PLUGIN_DIR}/"
        [ -f "${SOURCE_DIR}/requirements.txt" ] && cp "${SOURCE_DIR}/requirements.txt" "${GEMINI_PLUGIN_DIR}/"
        [ -f "${SOURCE_DIR}/GEMINI.md" ] && cp "${SOURCE_DIR}/GEMINI.md" "${GEMINI_PLUGIN_DIR}/"
        [ -f "${SOURCE_DIR}/.claude-plugin/plugin.json" ] && cp "${SOURCE_DIR}/.claude-plugin/plugin.json" "${GEMINI_PLUGIN_DIR}/plugin.json"

        # Expose all individual skills under ~/.gemini/config/skills/
        echo "  → Registering individual skills..."
        for skill_dir in "${SOURCE_DIR}/skills"/*/; do
            [ -d "${skill_dir}" ] || continue
            skill_name=$(basename "${skill_dir}")
            target="${GEMINI_SKILLS_DIR}/${skill_name}"
            rm -rf "${target}"
            mkdir -p "${target}"
            cp -r "${skill_dir}"* "${target}/"
        done

        if [ -d "${SOURCE_DIR}/extensions" ]; then
            for ext_dir in "${SOURCE_DIR}/extensions"/*/; do
                [ -d "${ext_dir}" ] || continue
                if [ -d "${ext_dir}skills" ]; then
                    for ext_skill in "${ext_dir}skills"/*/; do
                        [ -d "${ext_skill}" ] || continue
                        ext_skill_name=$(basename "${ext_skill}")
                        target="${GEMINI_SKILLS_DIR}/${ext_skill_name}"
                        rm -rf "${target}"
                        mkdir -p "${target}"
                        cp -r "${ext_skill}"* "${target}/"
                    done
                fi
            done
        fi

        # Make launcher executable
        local launcher_path="${GEMINI_PLUGIN_DIR}/${launcher_subpath}"
        chmod +x "${launcher_path}"

        # Rewrite docs in ~/.gemini/config/skills to use absolute path to launcher
        rewrite_doc() {
            local doc="$1" temp_doc
            temp_doc="${doc}.tmp"
            sed -e "s#\"\${CLAUDE_PLUGIN_ROOT}/scripts/claude-seo\"#\"${launcher_path}\"#g" \
                -e "s#\${CLAUDE_PLUGIN_ROOT}/scripts/claude-seo#\"${launcher_path}\"#g" \
                -e "s#\${CLAUDE_PLUGIN_ROOT}/skills/#${GEMINI_SKILLS_DIR}/#g" \
                -e "s#claude-seo run#\"${launcher_path}\" run#g" \
                -e "s#claude-seo setup#\"${launcher_path}\" setup#g" \
                -e "s#claude-seo doctor#\"${launcher_path}\" doctor#g" \
                "${doc}" > "${temp_doc}"
            mv "${temp_doc}" "${doc}"
        }

        for skill_dir in "${GEMINI_SKILLS_DIR}"/*; do
            [ -d "${skill_dir}" ] || continue
            while IFS= read -r -d '' doc; do
                rewrite_doc "${doc}"
            done < <(find "${skill_dir}" -type f -name '*.md' -print0)
        done

        echo "→ Initializing Python runtime in ${GEMINI_PLUGIN_DIR}..."
        (cd "${GEMINI_PLUGIN_DIR}" && "${launcher_path}" setup) || true
    fi

    echo ""
    echo "════════════════════════════════════════════════════════"
    echo "✓ SEO Toolkit for Gemini & Antigravity is ready!"
    echo "════════════════════════════════════════════════════════"
}

main "$@"
