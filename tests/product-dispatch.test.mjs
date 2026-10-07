import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFile} from 'node:fs/promises';
import {createRequire} from 'node:module';
import {execFileSync} from 'node:child_process';
const {chromium}=createRequire(import.meta.url)('@playwright/test');
// Also exercise the selectively staged checkpoint, independent of unrelated local PDP edits.
const source=path=>process.env.DISPATCH_TEST_INDEX==='1' ? execFileSync('git',['show',':'+path],{encoding:'utf8'}) : readFile(new URL('../'+path,import.meta.url),'utf8');
const form=await source('snipplets/product/product-form.tpl');
const snippet=await source('snipplets/product/product-dispatch.tpl');
const scss=await source('static/css/single-product.scss');
const store=await source('static/js/store.js.tpl');
test('dispatch mounts only after units inside native available state, with no business logic or shipping changes',()=>{
 const available=form.slice(form.indexOf('<span class="js-product-availability-available'),form.indexOf('<span class="js-product-availability-unavailable'));
 assert.match(available,/product-dispatch\.tpl/);assert.ok(available.indexOf('product-availability-stock')<available.indexOf('product-dispatch.tpl'));
 assert.match(snippet,/custom_product_dispatch/);
 assert.doesNotMatch(snippet,/12:00|cutoff|timeZone|postcode|zipcode|<script|metafields/);
 assert.equal((form.match(/product-dispatch\.tpl/g)||[]).length,1);
 const adapter=store.includes('function productAvailabilityStock(') ? store.slice(store.indexOf('function productAvailabilityStock('),store.indexOf('// Prefer an actual interest-free plan;')) : '';
 const legacy=store.slice(store.indexOf("var availabilityAvailable = parent.find("),store.indexOf('{# Updates installments on list item'));
 assert.ok(adapter || legacy.includes('availabilityAvailable.toggle(variant.available)'));
 assert.doesNotMatch(adapter,/dispatch|fetch|MutationObserver/);
});
test('native stock alone gates dispatch through available/unknown/zero and successive variants; layouts stay inline',async t=>{
 const browser=await chromium.launch({channel:'chrome'});t.after(()=>browser.close());
 const adapter=store.includes('function productAvailabilityStock(') ? store.slice(store.indexOf('function productAvailabilityStock('),store.indexOf('// Prefer an actual interest-free plan;')) : '';
 const legacy=store.slice(store.indexOf("var availabilityAvailable = parent.find("),store.indexOf('{# Updates installments on list item'));
 const rules=scss.slice(scss.indexOf('.single-product-page .product-dispatch-region {'),scss.indexOf('.single-product-page {',scss.indexOf('.single-product-page .product-dispatch-region {')));
 for(const width of [440,1920])await t.test(String(width),async()=>{
  const page=await browser.newPage({viewport:{width,height:900}});
  try{
   await page.setContent(`<style>.product-availability-status{display:inline-flex;align-items:center;gap:${width===440?6:8}px}.product-availability{font:400 9px/24px sans-serif}.product-availability-stock[hidden]{display:none}${rules}</style><main id="product" class="single-product-page"><div class="product-availability"><span class="js-product-availability-available product-availability-status"><strong class="js-product-availability-stock-fallback">En stock</strong><span class="js-product-availability-stock-label product-availability-stock">· Quedan <span class="js-product-availability-stock-count"></span> unidades</span>${snippet.replace(/\{\{ component[^\n]+\}\}/,'<div data-nubesdk-slot="custom_product_dispatch"></div>')}</span><span class="js-product-availability-unavailable">Sin stock</span></div><div id="shipping">Native shipping</div></main>`);
   const slot=page.locator('[data-nubesdk-slot="custom_product_dispatch"]');
   assert.equal(await slot.innerText(),'');
   await slot.evaluate(el=>{el.innerHTML='<span>· despacho hoy si comprás en los próximos <strong>0 h 1 min</strong></span>'});
   for(const [stock,available,visible] of [[5,true,true],[0,!!adapter,false],[null,true,true],[-1,true,true],[5,false,false],[2,true,true]]){
    await page.evaluate(({adapter,legacy,stock,available})=>{
      if(adapter){(0,eval)(adapter);updateProductAvailability({element:'#product',stock,available});}
      else {
        const variant={stock,available};
        const parent={find(selector){const el=document.querySelector(selector);return {length:el?1:0,toggle(show){el.style.display=show?'':'none'}}}};
        eval(legacy);
      }
    },{adapter,legacy,stock,available});
    assert.equal(await slot.isVisible(),visible);
    assert.equal(await page.locator('.product-availability').count(),1);
    assert.equal(await page.locator('#shipping').innerText(),'Native shipping');
   }
   const metrics=await page.locator('.product-dispatch-region').evaluate(e=>({font:getComputedStyle(e).fontSize,line:getComputedStyle(e).lineHeight,color:getComputedStyle(e).color}));
   assert.equal(metrics.font,width===440?'9px':'12px');assert.equal(metrics.line,'24px');
   await slot.evaluate(el=>{el.textContent=''});
   assert.match(await page.locator('.product-availability').innerText(),adapter ? /En stock.*Quedan 2 unidades/s : /En stock/);
   assert.doesNotMatch(await page.locator('.product-availability').innerText(),/despacho/);
  }finally{await page.close()}
 });
});
