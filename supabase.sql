create table if not exists public.appointments (
 id uuid primary key default gen_random_uuid(),
 date date not null,
 time time not null,
 name text not null,
 phone text not null,
 service text not null,
 status text not null default 'pending' check (status in ('pending','paid','cancelled','confirmed')),
 payment_id text unique,
 created_at timestamptz not null default now(),
 unique(date,time)
);
alter table public.appointments enable row level security;
create policy "public can see occupied paid slots" on public.appointments for select using (status in ('paid','confirmed'));
create or replace function public.create_pending_appointment(p_date date,p_time time,p_name text,p_phone text,p_service text)
returns uuid language plpgsql security definer as $$
declare new_id uuid;
begin
 insert into public.appointments(date,time,name,phone,service,status) values(p_date,p_time,p_name,p_phone,p_service,'pending') returning id into new_id;
 return new_id;
exception when unique_violation then raise exception 'HORARIO_OCUPADO'; end;$$;
