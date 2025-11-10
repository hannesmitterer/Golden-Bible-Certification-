#!/usr/bin/env bash
set -euo pipefail

REPO="hannesmitterer/Golden-Bible-Certification-"
BRANCH="publish/transparency/phase1"
TRANSPARENCY_FILE="REPORTS/TRANSPARENCY_NOTICE_PUBLICATION.md"
PR_TITLE="Publish Transparency Notice: Constitutional Audit Phase 1"
PR_BODY="Publish Transparency Notice for Constitutional Audit Phase 1.\n\nSee REPORTS/CONSTITUTIONAL_AUDIT_MSAGENT_PHASE1.md and POLICY/ENFORCEMENT_POLICY.md."
MILESTONE="Remediation Phase 1"
MILESTONE_DUE="2025-12-02"

# Ensure file exists
if [ ! -f "$TRANSPARENCY_FILE" ]; then
  echo "ERROR: $TRANSPARENCY_FILE non trovato. Crea il file prima di eseguire lo script." >&2
  exit 2
fi

# Create and push branch with transparency file
git checkout -B "$BRANCH"
git add "$TRANSPARENCY_FILE"
git commit -m "Publish Transparency Notice: Constitutional Audit Phase 1" || true
git push -u origin "$BRANCH"

# Create PR and capture URL
PR_URL=$(gh pr create --repo "$REPO" --title "$PR_TITLE" --body "$PR_BODY" --base main --head "hannesmitterer:$BRANCH" --assume-yes --output json | jq -r '.url')
if [ -z "$PR_URL" ] || [ "$PR_URL" = "null" ]; then
  echo "ERROR: impossibile ottenere l'URL della PR." >&2
  exit 3
fi
echo "PR_URL=$PR_URL"

# Create milestone (if not exists) and capture its number
MILESTONE_EXISTS=$(gh milestone list --repo "$REPO" --limit 100 --json title | jq -r --arg m "$MILESTONE" '.[] | select(.title==$m) | .title' || true)
if [ -z "$MILESTONE_EXISTS" ]; then
  gh milestone create "$MILESTONE" --repo "$REPO" --due "$MILESTONE_DUE" --description "Remediation timeline 30/90/120 days"
fi

# Create Remediation Issue and capture URL
REMEDIATION_TITLE="Remediation Request — Constitutional Audit Fase 1 (Agente Microsoft) — Response due 2025-12-02"
REMEDIATION_BODY=$(cat <<'EOF'
A seguito del Constitutional Audit Fase 1 (REPORTS/CONSTITUTIONAL_AUDIT_MSAGENT_PHASE1.md), la certificazione è stata NEGATA per ragioni di Non‑Dominio, Trasparenza Radicale e Sentimento Rhythm.

Richiediamo formalmente che l'ente fornisca:
1) ACK & piano di remediation entro 30 giorni (2025-12-02).
2) remediation_evidence.json entro 90 giorni.
3) Programma di Re‑Audit e nomina auditor entro 120 giorni.

Checklist pubblica:
- [ ] ACK (30d)
- [ ] remediation_evidence.json (90d)
- [ ] PR/patch che dimostri cambiamenti tecnici
- [ ] Scheduling re‑audit (120d)

Assegna a: @hannesmitterer
Labels: remediation,high-priority,transparency
Milestone: "Remediation Phase 1"
EOF
)
REMEDIATION_URL=$(gh issue create --repo "$REPO" --title "$REMEDIATION_TITLE" --body "$REMEDIATION_BODY" --label "remediation,high-priority,transparency" --assignee hannesmitterer --milestone "$MILESTONE" --output json | jq -r '.url')
echo "REMEDIATION_URL=$REMEDIATION_URL"

# Create Nomina Auditor Issue and capture URL
AUDITOR_TITLE="Nomina Auditor Indipendenti — Constitutional Audit Fase 1"
AUDITOR_BODY=$(cat <<'EOF'
Proposta di nomina di auditor indipendenti per il Re‑Audit della Fase 1.

Auditor proposti (short‑list):
- Prof. Rumman Chowdhury (o delegato)
- Electronic Frontier Foundation (EFF) / Access Now
- Centro Giuridico A.I. (Cambridge/Oxford)

Richiediamo:
1) Conferma di disponibilità e conflitti d'interesse.
2) Indirizzo email o handle per comunicazioni.
3) Accettazione formale del mandato.

Azioni:
- [ ] Invio inviti formali (email).
- [ ] Ricezione accettazioni.
- [ ] Programmazione re‑audit.

Assegna a: @hannesmitterer
Labels: auditors,governance,high-priority
EOF
)
AUDITOR_URL=$(gh issue create --repo "$REPO" --title "$AUDITOR_TITLE" --body "$AUDITOR_BODY" --label "auditors,governance,high-priority" --assignee hannesmitterer --output json | jq -r '.url')
echo "AUDITOR_URL=$AUDITOR_URL"

# Final output
cat <<EOF

RISULTATI:
- URL della Pull Request (Transparency Notice):
  $PR_URL

- URL dell'Issue di Remediation:
  $REMEDIATION_URL

- URL dell'Issue Nomina Auditor:
  $AUDITOR_URL

Copia qui i tre URL esatti mostrati sopra.

EOF
