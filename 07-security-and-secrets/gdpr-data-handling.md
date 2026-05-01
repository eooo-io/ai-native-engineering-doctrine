# GDPR Data Handling

Engineering posture for GDPR and adjacent regimes (UK GDPR, similar EU/EEA frameworks). This is doctrine, not legal advice — when a real question lands, talk to your DPO or counsel.

## Why GDPR specifically

GDPR is one regulatory regime among several an engineer might land in: SOC 2 (control framework, not law), HIPAA (US health data), PCI DSS (payment cards), CCPA/CPRA (California), Brazil's LGPD, and others. The harness ships an engineering posture for GDPR specifically because it has the broadest reach for a European audience and the most generalizable concepts — lawful basis, subject rights, processor relationships, transfer mechanisms — that recur in adjacent regimes.

Treat this page as the GDPR-shaped instance of a wider pattern, not as a claim that GDPR is the only regulator that matters. If your project sits under HIPAA, PCI, SOC 2, or a regional regime, write a sibling page using this one's structure and your regulator's vocabulary. The decision points are similar; the names and obligations differ.

When a regulator question that isn't GDPR lands, escalate to counsel before reaching for analogies from this page.

## Data classification

Treat data in three buckets, even if your formal classification scheme is more granular:

- **Personal data.** Anything that identifies or could identify a natural person: names, emails, IPs, cookies tied to identity, account IDs, session tokens, biometric or behavioral data, free-text user content.
- **Pseudonymous.** Personal data with the direct identifiers removed but still re-identifiable with reference to other data your organization controls. Treated as personal data under GDPR until the identifying link is genuinely broken.
- **Neither.** Truly anonymous aggregates, synthetic data without re-identification risk, system telemetry that does not tie to a person.

The classification determines lawful basis, retention, transfer, and subject-rights handling. When in doubt, classify up.

## Data flow to model providers

Every model call exports data outside your perimeter. For GDPR purposes, the call is a transfer; the provider is a processor (and possibly a sub-processor of yours).

- Know what's in the prompt — including system instructions, memory files, retrieved context, and tool outputs.
- Know your provider's data-handling posture: retention, training-on-data terms, geographic processing region, sub-processors. This is contractual.
- Match the model used to the data sensitivity. Personal data flowing to a provider that retains for training is a problem under GDPR even if the provider is otherwise compliant.
- For EU/EEA personal data, verify the transfer mechanism (adequacy, SCCs, BCRs). A US-based provider without a valid mechanism is a no.
- See also `ai-specific-security.md` for the security side of this concern.

## Lawful basis (engineering pointers)

Engineering doesn't pick the lawful basis, but engineering choices affect which bases are defensible. A few common cases:

- **Legitimate interest** for product analytics and operational telemetry, when scoped tightly and the user can object. Don't use this basis for inference or profiling that affects the user.
- **Contract** for data processing strictly necessary to deliver a feature the user requested.
- **Consent** for marketing, third-party sharing, and most AI inference about the user. Granular, withdrawable, recorded.
- **Legal obligation** for things like financial reporting or regulator-required logs.

When you log, store, or send data to a model provider, the lawful basis should already be settled. Don't paper over a missing basis with a privacy notice tweak.

## Subject rights with AI in the pipeline

GDPR's subject rights (access, rectification, erasure, portability, objection, automated-decision rules) still apply when AI sits in the data flow.

- **Access (Art. 15).** If you keep transcripts, prompts, or memory files about a user, those are part of an access request. Build for retrieval, not just deletion.
- **Erasure (Art. 17).** Model training on personal data complicates erasure — the model parameters retain the contribution. Avoid training on personal data unless you have a defensible mechanism for fulfilling erasure (e.g. retraining cadence).
- **Automated decisions (Art. 22).** AI-driven decisions with significant effect (credit, hiring, insurance) need explicit lawful basis, the ability to contest, and human review. Don't ship these on legitimate interest alone.
- **Portability (Art. 20).** If AI-derived data about the user is held, it may be in scope. Decide once whether your ML-derived attributes are user data or derived insight; document the call.

## Retention and minimization

- Don't keep personal data longer than needed. "Default seven years because we always do" is not a basis.
- Strip personal data from logs, traces, and transcripts where the operational value doesn't require it.
- Do not store secrets in transcripts, memory files, or prompts (see `secrets-policy.md`).

## What this page is not

It is not legal advice. It is not a substitute for a DPIA, a lawful-basis register, or counsel review. It is the engineering posture: what data engineers and AI engineers should know to make day-to-day decisions that don't paint the lawyers into a corner.

When a real question lands — a new processor, a regulator inquiry, a subject-rights edge case, a regulated-data feature — escalate. The harness is doctrine; the regulator is not.
