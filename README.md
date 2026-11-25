# Criador de Camisas

No ar em: **https://feliphe-galdino.github.io/CreateYourShirt/** (GitHub Pages, branch `gh-pages`). O QR code para o site está em `qrcode.png` e `qrcode.svg`.

Site estático (um único `index.html`) para montar uma camisa de time: nome, número, tamanho, fonte, cores, padrão, gola, escudo e patrocínio. Mostra frente e costas, publica as camisas numa galeria que todo mundo vê (Camisas criadas), baixa a imagem em PNG e gera um link que abre a mesma camisa.

## Galeria pública "Camisas criadas" (Supabase, grátis)

Para todo mundo ver as camisas criadas, o site usa um banco de dados grátis no Supabase. Enquanto o `config.js` estiver vazio, as camisas ficam só no navegador de quem criou.

1. Crie uma conta em https://supabase.com (dá para entrar com o GitHub) e clique em **New project**. Escolha a região **South America (São Paulo)** e anote a senha do banco.
2. No projeto, abra **SQL Editor**, cole todo o conteúdo de `supabase.sql` e clique em **Run**.
3. Vá em **Project Settings → API Keys** (ou **Data API**) e copie a **Project URL** e a chave **publishable** (começa com `sb_publishable_`; em projetos antigos se chama **anon public**).
4. Cole as duas no `config.js` e publique (push na branch `gh-pages`).

Essas duas informações são públicas por natureza. Quem protege o banco são as regras do `supabase.sql`: todos veem e publicam, mas só quem criou uma camisa (no mesmo navegador) consegue editar ou excluir. Para apagar qualquer camisa como administrador, use **Table Editor → camisas** no painel do Supabase.

Projetos grátis do Supabase são pausados depois de 7 dias sem nenhum acesso. Se isso acontecer, é só entrar no painel e clicar em **Restore**.

## Alternativa: publicar no Render (grátis)

O repositório já tem o `render.yaml`, igual ao da pizzaria. Ele cria um **Static Site** no plano gratuito, que não "dorme" e já vem com HTTPS.

1. Entre em https://dashboard.render.com com a conta do GitHub.
2. **New → Blueprint** e escolha o repositório `CreateYourShirt`.
3. Em *Branch*, escolha a branch onde está o site (ou a `main`, depois de fazer o merge).
4. Clique em **Apply**. Em cerca de 1 minuto o site fica no ar em `https://criador-de-camisas.onrender.com`.

Cada novo push nessa branch publica sozinho.

Para atualizar o site no GitHub Pages, faça push na branch `gh-pages`.

Se usar o Render, troque `feliphe-galdino.github.io/CreateYourShirt/` nas 3 linhas de `og:image`, `og:url` e `canonical` no começo do `index.html`.

Arquivos:

- `index.html`: o app inteiro (HTML, CSS e JS)
- `fonts/`: fontes hospedadas localmente (Anton, Barlow, Barlow Condensed, Bebas Neue, Graduate, Russo One, Teko, todas licenciadas sob a SIL Open Font License)
- `favicon.svg`, `share.png`: ícone da aba e imagem de prévia para redes sociais
- `config.js`: endereço e chave do Supabase (galeria pública)
- `supabase.sql`: script que cria o banco da galeria
- `render.yaml`: configuração da hospedagem no Render
