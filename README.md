# Football Training

Personal football training hub: drills, weekly plans, fitness, and progress logs.

## Structure
- `plans/` – weekly and seasonal training plans
- `drills/` – drill library (technical, tactical, physical)
- `logs/` – session logs and progress tracking

## Files
- `plans/high-low-routine.md` – the 12-week High/Low comeback routine
- `tracker.html` – check-in and progression tracker (published as a Claude artifact; data lives in the artifact's database)

## Supabase setup (index.html)
`index.html` is the same tracker backed by Supabase, to host as a static site (GitHub Pages or Vercel). There is no login: you are the only user.

1. Create a project at supabase.com.
2. SQL Editor: paste and run `supabase/schema.sql`.
3. Project Settings -> API: copy the Project URL and the `anon` public key into `config.js`.
4. Host the site and open it. Your numbers save straight to Supabase.

Anyone who has the site address and the anon key can read and write the tables, so don't share the address. If that ever matters, add Supabase Auth and tighten the policies.

## How targets work
Each exercise has a rep range and a set count. After you log a session, the next one shows a target:
- Hit the top of the range on every set: add load (2 kg, 1 kg for curls, 1 s for Nordics) and restart at the bottom of the range. Bodyweight moves (press-up, row, pike) suggest a harder variation instead.
- Otherwise: same load, one more rep.
- No gain for three sessions: take about 10% off and rebuild.

Items are labelled Loading, Mobility, Skill or Conditioning; the Week tab counts each type per week.
