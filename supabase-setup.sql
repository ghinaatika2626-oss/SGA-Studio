-- Jalankan sekali di Supabase: SQL Editor -> New query -> tempel -> Run
create table if not exists public.app_data (
  user_id uuid primary key references auth.users(id) on delete cascade,
  data jsonb not null,
  updated_at timestamptz not null default now()
);
alter table public.app_data enable row level security;
create policy "baca data sendiri"   on public.app_data for select using (auth.uid() = user_id);
create policy "tambah data sendiri" on public.app_data for insert with check (auth.uid() = user_id);
create policy "ubah data sendiri"   on public.app_data for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
