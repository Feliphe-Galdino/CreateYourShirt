# Criador de Camisas

Site estático (um único `index.html`) para montar uma camisa de time: nome, número, tamanho, fonte, cores, padrão, gola, escudo e patrocínio. Mostra frente e costas, salva as camisas no navegador (localStorage), baixa a imagem em PNG e gera um link que abre a mesma camisa.

## Publicar

Não precisa de build nem de servidor. Qualquer hospedagem estática serve:

- **GitHub Pages:** Settings → Pages → Deploy from a branch → escolha a branch e a pasta `/ (root)`.
- **Netlify / Vercel / Cloudflare Pages:** importe o repositório; sem comando de build, pasta de publicação `.`.

Arquivos:

- `index.html`: o app inteiro (HTML, CSS e JS)
- `fonts/`: fontes hospedadas localmente (Anton, Barlow, Barlow Condensed, Bebas Neue, Graduate, Russo One, Teko, todas licenciadas sob a SIL Open Font License)
- `favicon.svg`, `share.png`: ícone da aba e imagem de prévia para redes sociais

Depois de publicar, troque `share.png` em `og:image` pelo endereço completo (ex.: `https://seusite.com/share.png`) para a prévia aparecer no WhatsApp e nas redes.
