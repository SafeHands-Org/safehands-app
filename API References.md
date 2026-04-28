# Users
* GET /api/users/:id — Get user by ID
* PATCH /api/users/:id — Update user by ID
* DELETE /api/users/:id — Delete user by ID

---

# Families
* GET /api/families — Get all families
* POST /api/families — Create a family
* GET /api/families/:id — Get family by ID
* PUT /api/families/:id — Update family
* DELETE /api/families/:id — Delete family
* GET /api/families/members — Get all family members
* POST /api/families/members — Add a family member
* PUT /api/families/members/:fmId — Update family member
* DELETE /api/families/members/:fmId — Delete family member
* PUT /api/families/invitations — Create invitation
* GET /api/families/invitations/:token — Check invitation token

---

# Auth 
* POST /api/auth/register — Register new user
* POST /api/auth/login — Log in user
* GET /api/auth/me — Get current logged-in user

---

# Medications
* GET /api/medications — Get medications
* POST /api/medications — Create medication
* GET /api/medications/:id — Get medication by ID
* PUT /api/medications/:id — Update medication
* DELETE /api/medications/:id — Delete medication
* GET /api/medications/members — Get family member medications
* POST /api/medications/members — Assign medication to family member
* PUT /api/medications/members/:fmmId — Update family member medication
* DELETE /api/medications/members/:fmmId — Delete family member medication
Schedules
* GET /api/medications/schedules — Get medication schedules
* POST /api/medications/schedules — Create medication schedule
* PUT /api/medications/schedules/:schedId — Update medication schedule
* DELETE /api/medications/schedules/:schedId — Delete medication schedule
* GET /api/medications/logs — Get adherence logs
* POST /api/medications/logs — Create adherence log
* PUT /api/medications/logs/:logId — Update adherence log

---

# RXNorm
* GET /api/rxnorm/search — Search medications
* GET /api/rxnorm/:rxcui — Get medication details by RXCUI