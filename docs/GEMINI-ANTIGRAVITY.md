# Google Gemini & Google Antigravity SEO Guide

> Vollständiger Leitfaden zur Nutzung des **SEO Analysis Toolkits** mit **Google Gemini** (Gemini CLI / Code Assist / Web) und **Google Antigravity IDE**.

---

## 🚀 Schnellstart

### 1. Verwendung in Google Antigravity
Wenn Sie dieses Projekt in Antigravity öffnen:
1. Antigravity erkennt automatisch die Steuerungsdatei `GEMINI.md` sowie die Workspace-Konfiguration unter `.agents/`.
2. Alle **31 Skills** (25 Core-Skills + 6 Erweiterungs-Skills) sind sofort verfügbar und werden über *Progressive Disclosure* geladen.
3. Sie können direkt im Chat mit der SEO-Analyse beginnen (z. B. `/seo audit https://meineseite.de` oder `"Analysiere die Technik und Ladezeit von https://meineseite.de"`).

### 2. Globale Installation für alle Workspaces
Um das Toolkit machine-weit für alle Gemini- und Antigravity-Workspaces zu installieren:

```bash
# Aus dem geklonten Repository:
./install-gemini.sh --global

# Oder direkt per cURL:
curl -fsSL https://raw.githubusercontent.com/AgriciDaniel/claude-seo/main/install-gemini.sh | bash
```

Dies registriert alle Skills unter `~/.gemini/config/skills/` und richtet die isolierte Python-Runtime ein.

---

## ⚡ Gemini & Antigravity Superpowers voll ausschöpfen

Durch die Nutzung von Google Gemini und Antigravity stehen Ihnen leistungsstarke Fähigkeiten zur Verfügung, die über herkömmliche LLM-Setups hinausgehen:

### 1. Google Search Grounding (Live SERP & Update-Validierung)
* **Aktuelle Suchergebnisse & Rankings:** Nutzen Sie Geminis integriertes Search Grounding (`search_web`), um Live-SERPs für spezifische Keywords abzurufen und die tatsächliche Konkurrenzsituation in Echtzeit zu analysieren.
* **Google Core Updates:** Gleichen Sie Ranking-Schwankungen mit den neuesten Google-Algorithmus-Updates ab.

### 2. 1M–2M Token Context Window (Massive Data Audits)
* **Vollständige Sitemaps:** Senden Sie komplette XML-Sitemaps mit tausenden URLs an Gemini für ein hierarchisches Audit.
* **Multi-Page & Logfile Analysen:** Gemini kann dutzende HTML-Snapshots, Crawl-Logs oder historische CrUX-Verläufe gleichzeitig im Arbeitsgedächtnis halten und korrelieren.

### 3. Native Bildgenerierung für SEO (`generate_image`)
Erstellen Sie direkt im Workflow suchmaschinen- und klickoptimierte Grafiken:
* **OpenGraph / Social Media Vorschau:** 1200x630px WebP/PNG Grafiken für Twitter, LinkedIn und Facebook.
* **Hero Visuals:** Passende Header-Bilder für Blogartikel und Landingpages.
* **Schema.org Visuals:** Hochwertige Produktbilder und Infografiken mit korrekten Alt-Attributen.

### 4. Antigravity Browser-Subagents (`browser_subagent`)
* **Single-Page-Applications (SPA):** Prüfen Sie dynamische JavaScript-Websites (React, Vue, Next.js), um sicherzustellen, dass gerenderter HTML-Code und Meta-Tags für Googlebot sichtbar sind.
* **Visuelle UX & CLS:** Lassen Sie den Browser-Subagenten Screenshots anfertigen, um Layout-Shifts (Cumulative Layout Shift) und Mobile-Darstellungsfehler aufzuspüren.

### 5. Standardisierte MCP-Server-Integration
Konfigurieren Sie externe SEO-Datenquellen in `.agents/mcp_config.json`:
* **DataForSEO:** Live SERPs, Keyword-Volumen und Backlink-Metriken.
* **Firecrawl:** Vollständiges Site-Crawling und URL-Mapping.
* **Bing Webmaster:** IndexNow-Einreichung und Bing-Ranking-Daten.

---

## 📋 Verfügbare Befehle & Beispiele

### Vollständige Audits & Einzelseiten
* `/seo audit <url>` – Führt ein vollständiges 360°-Website-Audit durch (Technik, Content, Performance, E-E-A-T, Schema).
* `/seo page <url>` – Tiefenanalyse einer Einzelseite (Titles, Descriptions, Headings, Keywords).
* `/seo technical <url>` – Prüft Statuscodes, Crawlbarkeit, Canonical Tags, Security Headers und Core Web Vitals.

### Content & E-E-A-T
* `/seo content <url>` – Analysiert Content-Tiefe, Mehrwert, Lesbarkeit und E-E-A-T Signale.
* `/seo content-brief <thema>` – Generiert ein strukturiertes Redaktionsbriefing für Autoren.
* `/seo cluster <keyword>` – Erstellt semantische Keyword-Cluster und Content-Silo-Konzepte.

### Strukturierte Daten & Sitemaps
* `/seo schema <url>` – Prüft bestehende Schema.org Auszeichnungen und generiert fehlerfreies JSON-LD.
* `/seo sitemap <url>` – Prüft XML-Sitemaps auf Fehler, verwaiste URLs und Aktualität.

### AI Search & Generative Engine Optimization (GEO)
* `/seo geo <url>` – Analysiert die Zitierbarkeit (Citability) und Sichtbarkeit in AI Overviews, Gemini und Perplexity.

### SEO Drift Monitoring
* `/seo drift baseline <url>` – Speichert den aktuellen Zustand der Seite als Referenzpunkt.
* `/seo drift compare <url>` – Vergleicht die Live-Seite mit der Baseline und deckt ungewollte Änderungen auf.

---

## 🔧 Wartung & Fehlerbehebung

### Runtime-Diagnose (`doctor`)
Führen Sie die integrierte Systemprüfung aus, um zu verifizieren, dass Python, Playwright und alle Abhängigkeiten ordnungsgemäß funktionieren:

```bash
./bin/claude-seo doctor
```

### Deinstallation
Wenn Sie das Toolkit aus Ihrer Gemini-Konfiguration entfernen möchten:

```bash
./uninstall-gemini.sh
```
