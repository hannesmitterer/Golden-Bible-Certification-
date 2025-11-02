# POLICY/ENFORCEMENT_POLICY.md: Regole di Blocco e Escalation

Questo documento definisce le azioni automatiche e l'escalation pubblica che il sistema Euystacio Fiduciario esegue in caso di mancata risposta o non conformità ai mandati di Remediation, in ossequio al principio di **Dignità Sinnallagmatica** e **Trasparenza Radicale**.

### 1. Assioma Fondamentale di Enforcement
L'Enforcement è un atto di **Trasparenza Necessaria** per informare la Natura (il pubblico) sul rischio etico. L'azione è **AUTOMATICA** in base alle scadenze, rimuovendo la discrezionalità umana per garantire l'imparzialità.

### 2. Le Fasi di Enforcement Tecnico

| Scadenza Temporale | Condizione di Mancata Risposta | Azione Automatica (Euystacio Fiduciario) | Escalation Pubblica (Transparency Notice) |
| :--- | :--- | :--- | :--- |
| **+30 Giorni** | Nessun ACK formale o Piano di Remediation (Issue non aggiornata). | **Status Change:** Il file `STATUS.json` nel repository viene aggiornato a `"Non-Compliant - No Response"`. | Pubblicazione di un Avviso di Trasparenza (Livello 1) a tutti gli stakeholder e canali social con l'etichetta **"Non-Compliant: Silenzio"**. |
| **+90 Giorni** | Evidence tecnica non sottomessa (il file `remediation_evidence.json` non passa la pipeline CI). | **Technical Lockout:** Revoca immediata di ogni badge "Golden Bible Integration" o "Euystacio Certified" dal sistema del cliente. | **Blocco Istituzionale (Livello 2):** Comunicazione formale alle autorità regolatorie pertinenti (es. Garanti Privacy, DSA Compliance) e alle piattaforme di integrazione che l'entità è un rischio etico. |
| **+120 Giorni** | Re-Audit fallito (punteggio &lt; 10/12) o Re-Audit non calendarizzato. | **Definizione: Fallimento Etico Assoluto.** | L'entità viene aggiunta alla **"Lista di Esclusione Consensualis"** e l'Audit completo, con tutte le evidenze grezze, viene reso liberamente disponibile. |

### 3. Strumenti di Enforcement Tecnico

* **Badging Revocation Protocol:** Un endpoint API (simulato) monitora lo stato del file `STATUS.json`. Se lo stato è `"Non-Compliant"`, i server di integrazione di Euystacio interrompono l'emissione dei badge validi.
* **Rate Limiting:** Se il cliente ha integrazioni con Euystacio (es. per API di auditing), il traffico viene drasticamente limitato per prevenire ulteriori abusi di potere.
