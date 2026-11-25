-- Criador de Camisas: banco da galeria pública "Camisas criadas".
-- Cole tudo no SQL Editor do Supabase e clique em Run. Pode rodar de novo sem problema.
--
-- Regras:
--   * qualquer pessoa vê todas as camisas;
--   * qualquer pessoa publica uma camisa nova;
--   * só quem criou (o navegador que guarda o código secreto daquela camisa) edita ou exclui.

create extension if not exists pgcrypto with schema extensions;

create table if not exists public.camisas (
  id            uuid primary key default gen_random_uuid(),
  dados         jsonb not null check (jsonb_typeof(dados) = 'object' and length(dados::text) <= 2000),
  token_hash    text not null,
  criada_em     timestamptz not null default now(),
  atualizada_em timestamptz not null default now()
);
create index if not exists camisas_atualizada_em on public.camisas (atualizada_em desc);

alter table public.camisas enable row level security;

-- Leitura pública só das colunas da camisa (o código secreto nunca sai do banco).
revoke all on public.camisas from anon, authenticated;
grant select (id, dados, criada_em, atualizada_em) on public.camisas to anon, authenticated;
drop policy if exists "todos veem as camisas" on public.camisas;
create policy "todos veem as camisas" on public.camisas for select to anon, authenticated using (true);

-- Publicar
create or replace function public.criar_camisa(p_dados jsonb, p_token text)
returns json language plpgsql security definer set search_path = public, extensions as $$
declare r public.camisas;
begin
  if p_token is null or length(p_token) not between 20 and 100 then raise exception 'token inválido'; end if;
  insert into public.camisas (dados, token_hash)
  values (p_dados, encode(digest(p_token, 'sha256'), 'hex'))
  returning * into r;
  return json_build_object('id', r.id, 'criada_em', r.criada_em, 'atualizada_em', r.atualizada_em);
end $$;

-- Editar (só com o código de quem criou)
create or replace function public.editar_camisa(p_id uuid, p_token text, p_dados jsonb)
returns json language plpgsql security definer set search_path = public, extensions as $$
declare r public.camisas;
begin
  update public.camisas
     set dados = p_dados, atualizada_em = now()
   where id = p_id and token_hash = encode(digest(coalesce(p_token, ''), 'sha256'), 'hex')
  returning * into r;
  if not found then raise exception 'sem permissão' using errcode = '42501'; end if;
  return json_build_object('id', r.id, 'criada_em', r.criada_em, 'atualizada_em', r.atualizada_em);
end $$;

-- Excluir (só com o código de quem criou)
create or replace function public.excluir_camisa(p_id uuid, p_token text)
returns boolean language plpgsql security definer set search_path = public, extensions as $$
begin
  delete from public.camisas
   where id = p_id and token_hash = encode(digest(coalesce(p_token, ''), 'sha256'), 'hex');
  if not found then raise exception 'sem permissão' using errcode = '42501'; end if;
  return true;
end $$;

revoke all on function public.criar_camisa(jsonb, text) from public;
revoke all on function public.editar_camisa(uuid, text, jsonb) from public;
revoke all on function public.excluir_camisa(uuid, text) from public;
grant execute on function public.criar_camisa(jsonb, text) to anon, authenticated;
grant execute on function public.editar_camisa(uuid, text, jsonb) to anon, authenticated;
grant execute on function public.excluir_camisa(uuid, text) to anon, authenticated;
