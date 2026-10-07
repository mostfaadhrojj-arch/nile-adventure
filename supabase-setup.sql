-- شغّل هذا الملف في Supabase: SQL Editor > New query > Run
-- (استخدم مشروعاً جديداً مخصصاً للعبة الأطفال، لا مشروع تطبيق آخر)

create table if not exists public.households (
  id         uuid primary key references auth.users(id) on delete cascade,
  data       jsonb not null default '{}'::jsonb,   -- اسم ولي الأمر + ألقاب الأطفال + النقاط والإحصاءات (بلا أسماء حقيقية)
  updated_at timestamptz not null default now()
);

alter table public.households enable row level security;

create policy "owner can read"   on public.households for select using ((select auth.uid()) = id);
create policy "owner can insert" on public.households for insert with check ((select auth.uid()) = id);
create policy "owner can update" on public.households for update using ((select auth.uid()) = id) with check ((select auth.uid()) = id);
create policy "owner can delete" on public.households for delete using ((select auth.uid()) = id);
