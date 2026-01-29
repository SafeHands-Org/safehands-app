# Primary Caregiver User Stories
## US#1: Primary Caregiver Registration (Signup)
As a caregiver, I want to create an account so I can securely manage my family’s medication data. When I provide all the required information, the system should verify my credentials. If they are valid, my account should be created and I should be redirected to the onboarding page.
### Acceptance Criteria
- User must provide: full name, email, password, and password confirmation.
- Email must be valid format and unique.
- Password must meet minimum security rules (we'll decide that later).
- On success:
    - Account is created.
    - User is automatically logged in
    - User is redirected to the onboarding page.
- On failure:
    - If email already exists, show “Account already exists.”
    - If password requirements fail, show validation message.
    - If network/server error, show retry option without clearing form.

## US#2: Primary Caregiver Authentication (Login)
As a registered caregiver, I want to log in to the platform. When I enter my email and password and click 'Log In', the system should verify my credentials. If they match the records in the database, I should be granted access to navigate the app and be redirected to the family dashboard.
### Acceptance Criteria
- User must provide: email and password.
- On success:
    - User is redirected to their family dashboard.
    - Session token is securely stored.
- On failure:
    - If credentials are incorrect, show “Incorrect email or password.”
    - If network error, allow retry without clearing input.
