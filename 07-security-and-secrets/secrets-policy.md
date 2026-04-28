# Secrets Policy

## Non-negotiable rules

- Never commit live secrets to source control.
- Treat any committed credential as exposed.
- Use environment variables, managed secret stores, or platform secret mechanisms.
- Keep `.env.example` public-safe and placeholder-only.
- Rotate secrets immediately after accidental exposure.
- Remove secrets from logs, screenshots, tickets, and chat transcripts.

## Rotation checklist

1. Generate or rotate the credential.
2. Update app configuration, workers, deployments, and CI variables.
3. Restart services that cache credentials.
4. Confirm reconnects.
5. Revoke the old credential.
6. Document the incident if required.
