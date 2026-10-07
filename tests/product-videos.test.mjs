import { test } from 'node:test';
import assert from 'node:assert/strict';
import { readFile } from 'node:fs/promises';

test('videos slot follows complementary products and precedes native long description', async () => {
  const template = await readFile(new URL('../templates/product.tpl', import.meta.url), 'utf8');
  const snippet = await readFile(new URL('../snipplets/product/product-videos.tpl', import.meta.url), 'utf8');
  assert.ok(template.indexOf('product-complementary-overview.tpl') < template.indexOf('product-videos.tpl'));
  assert.ok(template.indexOf('product-videos.tpl') < template.indexOf('product-description.tpl'));
  assert.equal((snippet.match(/type: "custom_product_videos"/g) || []).length, 1);
  assert.match(snippet, /product-videos-region/);
  assert.doesNotMatch(snippet, /youtubeUrl|iframe|<script|fetch\(|min-height|product\.description|metafields/);
});

test('empty slot has no heading, fixed height or fallback content', async () => {
  const snippet = await readFile(new URL('../snipplets/product/product-videos.tpl', import.meta.url), 'utf8');
  const empty = snippet.replace(/\{#[\s\S]*?#\}/g, '').replace(/\{\{[\s\S]*?\}\}/g, '').replace(/<[^>]+>/g, '').trim();
  assert.equal(empty, '');
});
