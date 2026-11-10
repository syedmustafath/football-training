-- Run this once in the Supabase dashboard: SQL Editor -> New query -> paste -> Run.
-- Single-user setup: no login. The anon key in config.js can read and write these
-- tables, so keep the site address to yourself.
--
-- If you ran an earlier version of this file (with user_id columns), uncomment
-- the next line first. It deletes those tables and anything logged in them.
-- drop table if exists public.days, public.lifts, public.checks, public.settings cascade;

create table if not exists public.days (
  date     date primary key,
  done     jsonb not null default '{}'::jsonb,
  complete boolean not null default false,
  knee     text not null default '',
  note     text not null default '',
  run      jsonb
);

create table if not exists public.lifts (
  id    uuid primary key default gen_random_uuid(),
  date  date not null,
  ex    text not null,
  load  numeric,
  reps  numeric not null,
  sets  int not null default 1,
  note  text not null default '',
  ts    bigint not null
);
create index if not exists lifts_ex_date on public.lifts (ex, date);

create table if not exists public.checks (
  date  date primary key,
  surg  numeric not null,
  other numeric not null
);

create table if not exists public.settings (
  id        int primary key default 1 check (id = 1),
  start     date,
  run_shift int not null default 0
);

do $$
declare t text;
begin
  foreach t in array array['days','lifts','checks','settings'] loop
    execute format('alter table public.%I enable row level security', t);
    execute format('drop policy if exists "open access" on public.%I', t);
    execute format('create policy "open access" on public.%I for all to anon, authenticated using (true) with check (true)', t);
    execute format('grant select, insert, update, delete on public.%I to anon, authenticated', t);
  end loop;
end $$;
