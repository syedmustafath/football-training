-- Run this once in the Supabase dashboard: SQL Editor -> New query -> paste -> Run.
-- Every table is locked to the signed-in user with row level security,
-- so the public anon key in config.js can never read or write anyone else's rows.

create table if not exists public.days (
  user_id  uuid not null default auth.uid() references auth.users on delete cascade,
  date     date not null,
  done     jsonb not null default '{}'::jsonb,
  complete boolean not null default false,
  knee     text not null default '',
  note     text not null default '',
  run      jsonb,
  primary key (user_id, date)
);

create table if not exists public.lifts (
  id      uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users on delete cascade,
  date    date not null,
  ex      text not null,
  load    numeric,
  reps    numeric not null,
  sets    int not null default 1,
  note    text not null default '',
  ts      bigint not null
);
create index if not exists lifts_user_ex_date on public.lifts (user_id, ex, date);

create table if not exists public.checks (
  user_id uuid not null default auth.uid() references auth.users on delete cascade,
  date    date not null,
  surg    numeric not null,
  other   numeric not null,
  primary key (user_id, date)
);

create table if not exists public.settings (
  user_id   uuid primary key default auth.uid() references auth.users on delete cascade,
  start     date,
  run_shift int not null default 0
);

do $$
declare t text;
begin
  foreach t in array array['days','lifts','checks','settings'] loop
    execute format('alter table public.%I enable row level security', t);
    execute format('drop policy if exists "own rows" on public.%I', t);
    execute format('create policy "own rows" on public.%I for all to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id)', t);
    execute format('grant select, insert, update, delete on public.%I to authenticated', t);
  end loop;
end $$;
