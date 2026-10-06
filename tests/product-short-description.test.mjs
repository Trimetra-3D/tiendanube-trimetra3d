import { test } from 'node:test';
import assert from 'node:assert/strict';
import { readFile } from 'node:fs/promises';

test('PDP exposes exactly one Mova short-description slot independently of the native long description', async () => {
  const snippet = await readFile(new URL('../snipplets/product/product-short-description.tpl', import.meta.url), 'utf8');
  const product = await readFile(new URL('../templates/product.tpl', import.meta.url), 'utf8');
  const css = await readFile(new URL('../static/css/single-product.scss', import.meta.url), 'utf8');
  assert.equal((snippet.match(/type: "custom_product_short_description"/g) || []).length, 1);
  assert.match(snippet, /class="product-short-description-region"/);
  assert.doesNotMatch(snippet, /product\.metafields|product\.description|<section|<script|fetch\(/);
  assert.ok(product.indexOf('product-form.tpl') < product.indexOf('product-short-description.tpl'));
  assert.ok(product.indexOf('product-short-description.tpl') < product.indexOf('product-benefits.tpl'));
  assert.match(product, /product-description\.tpl/);
  assert.doesNotMatch(css, /product-short-description-region:has\(|mova-short-description-ready-/);
});

test('an empty SDK slot leaves no theme-generated short description or fallback copy', async () => {
  const snippet = await readFile(new URL('../snipplets/product/product-short-description.tpl', import.meta.url), 'utf8');
  // Contract check: if the SDK contributes no content, only the mount wrapper remains.
  const emptySlotMarkup = snippet.replace(/\{\{\s*component\('nubesdk-slot',\s*\{\s*type:\s*"custom_product_short_description"\s*\}\)\s*\}\}/, '');
  assert.equal(emptySlotMarkup.replace(/\s+/g, ' ').trim(), '<div class="product-short-description-region"> </div>');
  assert.doesNotMatch(emptySlotMarkup, /Sobre este producto|metafields|\{%|\{\{/);
});
