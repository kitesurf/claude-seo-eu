# Gemini & Antigravity SEO: Universal SEO Analysis Toolkit

> **Instruktionen für Google Gemini (CLI, Web, Code Assist) und Google Antigravity Agents**
> Für Claude Code Nutzer: siehe `CLAUDE.md`. Für Multi-Platform-Agents: siehe `AGENTS.md`.

---

## 🌟 Übersicht

Dieses Repository enthält das umfassendste Open-Source SEO-Analyse-Toolkit für KI-Agents:
* **25 Sub-Skills** (21 Core + 1 Orchestrator + 1 Framework + 2 Extension Mirrors)
* **18 spezialisierte Sub-Agents**
* **53 Python-Skripte** für crawl-, parse-, audit- und API-Operationen
* **Native Unterstützung für Gemini & Antigravity**: 1M–2M Token Kontextfenster, Google Search Grounding, native Bildgenerierung (`generate_image`) und Antigravity Browser-Subagents.

---

## 🛠️ Tool-Mapping für Antigravity & Gemini

Wenn Sie als Gemini- oder Antigravity-Agent in diesem Workspace agieren, mappen Sie Standard-Befehle und -Tools wie folgt:

| Vorgang / Claude-Äquivalent | Antigravity / Gemini Tool | Ausführung / Verwendung |
| :--- | :--- | :--- |
| **Python-Skripte ausführen** (`Bash`) | `run_command` | `./bin/claude-seo run <script_name>.py [args]` |
| **Dateien & Referenzen lesen** (`Read`) | `view_file` | Absolute Pfade zu `skills/*/references/*.md` oder HTML-Snapshots |
| **Reports / Schema generieren** (`Write`/`Edit`) | `write_to_file` / `replace_file_content` | Ausgabe strukturierter SEO-Reports, Briefings oder Schema.org JSON-LD |
| **Code / Sitemaps durchsuchen** (`Grep`/`Glob`) | `grep_search` / `list_dir` | Durchsuchen von Quellcode, HTML-Tags oder Sitemaps |
| **Bilder erstellen (OG, Hero, Schema)** | `generate_image` / `gemini_generate_image` | Native Bildgenerierung für SEO-Visuals |
| **Visuelle / SPA-Prüfung** | `browser_subagent` / `render_page.py` | Headless-Rendering, Screenshot-Analyse, CLS & Layout-Checks |
| **Live Google SERP / Updates prüfen** | `search_web` / Google Grounding | Echtzeit-Abgleich von Google Core Updates & Suchergebnissen |

---

## 🚀 Schnellreferenz: SEO-Befehle & Workflows

Die Skills können entweder über Slash-Commands (`/seo <cmd>`) oder durch direkte Prompts auf Deutsch/Englisch aufgerufen werden:

| Befehl / Intent | Was der Agent ausführt | Relevanter Skill & Skripte |
| :--- | :--- | :--- |
| `/seo audit <url>`<br>*"Führe ein SEO-Audit für [URL] durch"* | Vollständiges 360°-Website-Audit (Technik, Content, Performance, Schema, E-E-A-T) | `skills/seo-audit/`<br>`skills/seo/` |
| `/seo page <url>`<br>*"Analysiere diese Einzelseite"* | Tiefenanalyse einer spezifischen URL (On-Page, Meta, Headings, Keywords) | `skills/seo-page/`<br>`scripts/parse_html.py` |
| `/seo technical <url>`<br>*"Technisches SEO-Audit"* | Crawlbarkeit, Indexierbarkeit, Status Codes, Canonical, Security, Core Web Vitals | `skills/seo-technical/`<br>`scripts/fetch_page.py` |
| `/seo content <url>`<br>*"Content- und E-E-A-T-Analyse"* | Analyse von Qualität, Tiefe, Helpful Content Kriterien, Autoren-Signalen & Lesbarkeit | `skills/seo-content/`<br>`scripts/content_quality.py` |
| `/seo content-brief <thema>`<br>*"Erstelle ein Content-Briefing"* | Generiert ein suchmaschinen- & nutzeroptimiertes Redaktionsbriefing inklusive Cluster | `skills/seo-content-brief/` |
| `/seo schema <url>`<br>*"Strukturierte Daten prüfen/erstellen"* | Erkennung, Validierung & JSON-LD Generierung (Organization, Product, FAQ, Article, etc.) | `skills/seo-schema/`<br>`scripts/schema_generate.py` |
| `/seo sitemap <url>`<br>*"Sitemap prüfen"* | XML-Sitemap-Discovery, Status-Check, Quality Gates, Generierung | `skills/seo-sitemap/`<br>`scripts/sitemap_discovery.py` |
| `/seo geo <url>`<br>*"GEO & AI Overviews Optimierung"* | AI Crawler Zugänglichkeit (GPTBot, Google-Extended, Perplexity), Citability-Check | `skills/seo-geo/` |
| `/seo sxo <url>`<br>*"Search Experience Optimierung"* | UX, User Stories, Personas, Wireframe-Konzepte & Search Intent Match | `skills/seo-sxo/` |
| `/seo cluster <keyword>`<br>*"Semantic Keyword Clustering"* | Semantische Keyword-Cluster, Content-Architektur & Topic Maps | `skills/seo-cluster/` |
| `/seo drift baseline <url>`<br>*"SEO-Baseline erfassen"* | Erfasst aktuellen SEO-Zustand in lokaler SQLite-Datenbank zur Überwachung | `skills/seo-drift/`<br>`scripts/drift_baseline.py` |
| `/seo drift compare <url>`<br>*"Mit Baseline vergleichen"* | Erkennt Drift/Regressionen gegenüber dem vorherigen Zustand (17 Prüfregeln) | `skills/seo-drift/`<br>`scripts/drift_compare.py` |
| `/seo ecommerce <url>`<br>*"E-Commerce SEO"* | Produktschema, Merchant Center Signale, UCP (Universal Commerce Protocol) | `skills/seo-ecommerce/`<br>`scripts/ucp_check.py` |
| `/seo google [cmd] <url>`<br>*"Google APIs abfragen"* | Google Search Console, PageSpeed Insights, CrUX History, Indexing API, GA4 | `skills/seo-google/`<br>`scripts/pagespeed_check.py` |
| `/seo backlinks <url>`<br>*"Backlink-Profil analysieren"* | Moz DA/PA, Bing Webmaster Links, Common Crawl Web Graph & Verifikation | `skills/seo-backlinks/`<br>`scripts/verify_backlinks.py` |
| `/seo image-gen <prompt>`<br>*"SEO Bild generieren"* | Social OG Images, Hero Visuals, Schema Images (Gemini / Imagen) | `skills/seo-image-gen/` |

---

## ⚡ Superpowers mit Gemini & Antigravity

### 1. 1M–2M Context Window (Full Site & Big Data Audits)
* **Bulk-Analysen:** Ganze XML-Sitemaps, Logdateien oder mehrere Dutzend HTML-Seiten können in einer einzigen Sitzung geladen und analysiert werden.
* **Historischer Drift:** Mehrere Drift-Snapshots und historische CrUX-Wochenverläufe (`scripts/crux_history.py`) können parallel verglichen werden.

### 2. Google Search Grounding & Live SERP Verification
* Nutzen Sie Geminis Such-Grounding / `search_web`, um aktuelle SERP-Layouts, Google Core Updates (`data/google-updates.json`), AI Overviews Ausspielungen und Rich Results in Echtzeit zu verifizieren.

### 3. Native Bildgenerierung für SEO
* Generierung von performanten WebP/PNG Social-Share-Grafiken (OpenGraph 1200x630), Blog-Header-Grafiken und Produktvisualisierungen direkt über das Antigravity `generate_image` Tool.

### 4. Antigravity Browser Subagents
* Für interaktive Single-Page-Applications (React, Vue, Next.js), Client-Side-Rendering-Prüfungen oder visuelle Layout-Shift-Probleme (CLS) kann direkt ein `browser_subagent` gestartet werden.

---

## 📁 Ausführung von Python-Skripten im Projekt

Alle Skripte werden über das isolierte Runtime-System gestartet:

```bash
# HTML & Metadaten analysieren
./bin/claude-seo run parse_html.py https://example.com

# PageSpeed Insights & Core Web Vitals abrufen
./bin/claude-seo run pagespeed_check.py https://example.com --json

# Drift Baseline speichern
./bin/claude-seo run drift_baseline.py https://example.com

# Schema generieren
./bin/claude-seo run schema_generate.py Organization --name "Mein Unternehmen" --url "https://example.com"
```

---

## 🛡️ Sicherheits- & Qualitätsrichtlinien
* **SSRF-Schutz:** Alle Fetch-Skripte nutzen `url_safety.py` (Schutz vor privaten IP-Ranges und DNS-Rebinding).
* **Datensparsamkeit:** Keine sensiblen API-Schlüssel im Prompt oder Logs ausgeben; Anmeldedaten werden in `~/.config/claude-seo/` verwaltet.
* **E-E-A-T Exzellenz:** Bewertungen stützen sich auf reale Daten, offizielle Google Search Essentials und transparente Begründungen.
