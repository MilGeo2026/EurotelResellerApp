-- Einmalig im SQL-Editor des NEUEN eurotel-Supabase-Projekts ausführen.
-- Legt alle vier Tabellen an, die das Portal braucht: Kunden, Verträge,
-- Umfrage-Antworten und Tickets. Jede Tabelle speichert ihre Felder als
-- jsonb unter "data" (gleiches Schema wie im Geotab-Reseller-Portal), damit
-- neue Formularfelder später ohne Migration hinzugefügt werden können.

-- ── Kunden ──────────────────────────────────────────────────────────
create table if not exists public.kunden (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  data jsonb not null
);
alter table public.kunden enable row level security;

create policy "Nur angemeldete Nutzer duerfen lesen"
on public.kunden for select to authenticated using (true);
create policy "Nur angemeldete Nutzer duerfen anlegen"
on public.kunden for insert to authenticated with check (true);
create policy "Nur angemeldete Nutzer duerfen aendern"
on public.kunden for update to authenticated using (true) with check (true);
create policy "Nur angemeldete Nutzer duerfen loeschen"
on public.kunden for delete to authenticated using (true);

-- ── Verträge ────────────────────────────────────────────────────────
create table if not exists public.vertraege (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  data jsonb not null
);
alter table public.vertraege enable row level security;

create policy "Nur angemeldete Nutzer duerfen lesen"
on public.vertraege for select to authenticated using (true);
create policy "Nur angemeldete Nutzer duerfen anlegen"
on public.vertraege for insert to authenticated with check (true);
create policy "Nur angemeldete Nutzer duerfen aendern"
on public.vertraege for update to authenticated using (true) with check (true);
create policy "Nur angemeldete Nutzer duerfen loeschen"
on public.vertraege for delete to authenticated using (true);

-- ── Umfrage-Antworten ───────────────────────────────────────────────
-- Kunden füllen die Umfrage ohne Login aus -> anonymes Einreichen erlauben,
-- aber nur angemeldete Portal-Nutzer duerfen die Antworten lesen.
create table if not exists public.umfrage_antworten (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  data jsonb not null
);
alter table public.umfrage_antworten enable row level security;

create policy "Oeffentliches Einreichen erlaubt"
on public.umfrage_antworten for insert to anon with check (true);
create policy "Nur angemeldete Nutzer duerfen lesen"
on public.umfrage_antworten for select to authenticated using (true);

-- ── Tickets ─────────────────────────────────────────────────────────
create table if not exists public.tickets (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  data jsonb not null
);
alter table public.tickets enable row level security;

create policy "Nur angemeldete Nutzer duerfen lesen"
on public.tickets for select to authenticated using (true);
create policy "Nur angemeldete Nutzer duerfen anlegen"
on public.tickets for insert to authenticated with check (true);
create policy "Nur angemeldete Nutzer duerfen aendern"
on public.tickets for update to authenticated using (true) with check (true);
create policy "Nur angemeldete Nutzer duerfen loeschen"
on public.tickets for delete to authenticated using (true);
