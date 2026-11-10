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
`index.html` is the same tracker backed by Supabase, to host as a static site (GitHub Pages or Vercel).

1. Create a project at supabase.com.
2. SQL Editor: paste and run `supabase/schema.sql`. It creates the tables and locks each row to its owner.
3. Project Settings -> API: copy the Project URL and the `anon` public key into `config.js`.
4. Authentication -> URL Configuration: add your hosted site URL as the Site URL and a Redirect URL.
5. Open the site and sign in with your email. Then, in Authentication -> Sign In / Providers, turn off "Allow new users to sign up" so only you can get in.
