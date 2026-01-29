# Clinician User Stories
## US#1: Access Emergency View
As a clinician, I want read-only access to a patient’s medication profile so I can treat them safely. When I access the secure link or QR code, the system should redirect me to see the patients medication dashboard
### Acceptance Criteria
- Clinician accesses via secure link or QR code.
- No login required.
- On success:
    - Clinician sees medication list, dosages, schedules, allergies, and notes.
- On failure:
    - If link expired, show “Access expired.”
    - If invalid, show “Invalid access.”