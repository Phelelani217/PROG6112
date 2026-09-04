# RaceDay — POE Part 1: System Planning and Database

## Description
RaceDay is a system for managing running/race-day events. Organizers create events
and the categories within them (e.g. 10km, Half Marathon); Athletes register,
browse events, enrol into a category for a specific event, and view their results
once the Organizer has captured them after race day.

This part of the POE is planning only — no application code is included. It
demonstrates the data model and API design that Part 2's implementation must follow.

## Repository structure
```
RaceDay_POE/
├── README.md
├── .github/
│   └── workflows/
│       └── validate-structure.yml   # CI: checks /docs exists with required files
└── docs/
    ├── RaceDay_ERD.png              # Entity Relationship Diagram (Section A)
    ├── API_Endpoint_Plan.md         # API endpoint specification (Section B)
    └── RaceDay_Schema.sql           # SQL Server create + populate script (Section C)
```

## Roles

| Role | Description |
|---|---|
| **Athlete** | Registers an account, browses events, enrols in a category for a specific event, and views their own results once published. |
| **Organizer** | Registers an account, creates and manages events and their categories, and captures/updates results for athletes enrolled in their events. |

Role-based access is enforced at the API layer: every endpoint in
`docs/API_Endpoint_Plan.md` states which role can call it, and "owner" checks
mean an Organizer can only modify events/categories/results they created, and
an Athlete can only modify their own enrolments.

## Database (Section A & C)
The schema has 6 entities: `Role`, `User`, `Event`, `Category`, `Enrolment`, `Result`.

- `docs/RaceDay_ERD.png` shows the full diagram with primary keys, foreign keys,
  and cardinality for every relationship.
- `docs/RaceDay_Schema.sql` creates and populates the schema in SQL Server (SSMS)
  and matches the ERD exactly — table names, keys, and constraints line up 1:1.

To run it: open the script in SSMS connected to a clean instance and execute
the whole file. It drops and recreates `RaceDayDB`, so it's safe to re-run.

## API endpoint plan (Section B)
`docs/API_Endpoint_Plan.md` lists every planned endpoint — HTTP method, route,
description, role required, request body, and expected response — covering
Authentication, User Profile, Events, Categories, Event Enrolments, and Results.
Part 2's implementation is expected to match this plan; any deviations will be
explained here once Part 2 is built.

## GitHub and CI/CD
- All planning documents and the SQL script are committed inside `/docs`.
- `.github/workflows/validate-structure.yml` runs on every push/PR to `main`
  and fails the build if `/docs` is missing or any required file
  (`RaceDay_ERD.png`, `API_Endpoint_Plan.md`, `RaceDay_Schema.sql`) is absent.

**Successful build screenshot:**
_(paste your green-check Actions screenshot here once you've pushed and the workflow has run)_

## Video walkthrough
_(add your unlisted YouTube link here — walk through the planning documents, your
ERD decisions, and the endpoint plan)_

## Submission checklist
- [ ] ERD, endpoint plan, and SQL script committed inside `/docs`
- [ ] SQL script tested on a clean SQL Server instance
- [ ] 20+ meaningful commits on your own GitHub account
- [ ] GitHub Actions workflow passing (green build)
- [ ] CI/CD screenshot added to this README
- [ ] Unlisted YouTube walkthrough recorded and linked above
- [ ] Repository link submitted on ARC
