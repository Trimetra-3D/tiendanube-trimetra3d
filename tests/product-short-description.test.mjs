import { test } from 'node:test';
import assert from 'node:assert/strict';
import { readFile } from 'node:fs/promises';

test('PDP exposes exactly one short-description SDK slot and keeps independent native fallbacks', async () => {
  const snippet = await readFile(new URL('../snipplets/product/product-short-description.tpl', import.meta.url), 'utf8');
  const product = await readFile(new URL('../templates/product.tpl', import.meta.url), 'utf8');
  const css = await readFile(new URL('../static/css/single-product.scss', import.meta.url), 'utf8');
  assert.equal((snippet.match(/type: "custom_product_short_description"/g) || []).length, 1);
  assert.ok(snippet.indexOf("component('nubesdk-slot'") < snippet.indexOf('{% if product_short_description %}'));
  assert.match(snippet, /product\.metafields\.trimetra\.short_description/);
  assert.doesNotMatch(snippet, /product\.description|<script|fetch\(/);
  assert.ok(product.indexOf('product-form.tpl') < product.indexOf('product-short-description.tpl'));
  assert.ok(product.indexOf('product-short-description.tpl') < product.indexOf('product-benefits.tpl'));
  assert.match(product, /product-description\.tpl/);
  assert.match(css, /product-short-description-region:has\(\[id\^="mova-short-description-ready-"\]\)/);
});
