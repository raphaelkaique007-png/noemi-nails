# Noemi Nail Design — Netlify + Supabase + Mercado Pago

O site já está preparado para Netlify. A agenda usa uma restrição única no banco (`date + time`) para impedir que duas clientes confirmem o mesmo horário.

## Antes de publicar
1. Crie um projeto no Supabase e execute `supabase.sql` no SQL Editor.
2. Copie a URL e a chave anon para o começo de `app.js`.
3. Crie sua conta/app no Mercado Pago e configure no Netlify as variáveis:
   - `SUPABASE_URL`
   - `SUPABASE_SERVICE_ROLE_KEY`
   - `MERCADOPAGO_ACCESS_TOKEN`
4. No Netlify, publique a pasta inteira deste projeto.
5. Para produção, o próximo passo é configurar o webhook do Mercado Pago para alterar o agendamento de `pending` para `paid` somente quando o pagamento do sinal for aprovado.

### Regra importante
O front-end nunca deve ser usado para considerar o pagamento como aprovado. A confirmação real deve vir do webhook do Mercado Pago. Assim o horário só aparece como ocupado para outras clientes quando estiver pago/confirmado.

### Horários
Sexta: 20h
Sábado: 08h, 10h, 12h, 14h, 15h
Domingo: 08h, 10h, 12h, 14h

Ajuste os tempos em `app.js` caso o intervalo real dos procedimentos seja diferente.

## Pagamento automático
No Netlify, adicione também `SERVICE_PRICES_JSON`, por exemplo:
`{"Alongamento em Gel":170,"Banho de Gel":100,"Esmaltação em Gel":65,"Nail Art":80}`
O checkout cobra 50% do valor cadastrado. Ajuste os valores para os preços atuais da Noemi antes de publicar.

Configure no Mercado Pago a URL de webhook para `https://SEU-SITE.netlify.app/.netlify/functions/mercadopago-webhook`.
