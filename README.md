# Criador de Camisas

No ar em: **https://feliphe-galdino.github.io/CreateYourShirt/** (GitHub Pages, branch `gh-pages`). O QR code para o site está em `qrcode.png` e `qrcode.svg`.

Site estático (um único `index.html`) para montar uma camisa de time: nome, número, tamanho, fonte, cores, padrão, gola, escudo e patrocínio. Mostra frente e costas, salva as camisas no navegador (localStorage), baixa a imagem em PNG e gera um link que abre a mesma camisa.

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
- `render.yaml`: configuração da hospedagem no Render
