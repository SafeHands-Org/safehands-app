# Family Member User Stories
## US#1: Family Member Registration (Signup)
As a family member, I want to create an account via invitation so I can access my medication information. When I provide all the required information, the system should verify my credentials. If they are valid, my account should be created and I should be redirected to my medication dashboard.
### Acceptance Criteria
- User must provide: full name, email, password, confirm password, and birthday.
- Invite token must be valid.
- Password must meet minimum security rules (we'll decide that later).
- On success:
    - Account is created.
    - User is linked to the correct family group.
    - User is redirected to their medication dashboard.
- On failure:
    - If email already exists, show “Account already exists.”
    - If password requirements fail, show validation message.
    - If network/server error, show retry option without clearing form.
    - If invite token expired, show “Invite expired.”

## US#2: Family Member Authentication (Login)
As a family member, I want to log in so I can see my medication schedule. When I enter my email and password and click 'Log In', the system should verify my credentials. If they match the records in the database, I should be granted access to navigate the app and be redirected to my medication dashboard.
### Acceptance Criteria
- User must provide: email and password.
- On success:
    - User is redirected to their medication dashboard.
    - Session token is securely stored.
- On failure:
    - If credentials are incorrect, show “Incorrect email or password.”
    - If network error, allow retry without clearing input.