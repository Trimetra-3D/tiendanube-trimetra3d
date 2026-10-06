import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFile} from 'node:fs/promises';
import {createRequire} from 'node:module';
const require=createRequire(import.meta.url);
const {chromium}=require('@playwright/test');
const adapter=await readFile(new URL('../static/js/product-currency.js.tpl',import.meta.url),'utf8');
const snippet=await readFile(new URL('../snipplets/product/product-currency.tpl',import.meta.url),'utf8');
const scss=await readFile(new URL('../static/css/single-product.scss',import.meta.url),'utf8');
const quotedAt='2026-10-05T20:00:00Z',fetchedAt='2026-10-05T21:00:00Z',validUntil='2026-10-05T21:05:00Z';
const quote={source:'BNA',market:'billetes',currency:'USD',side:'compra',arsPerUsd:1490,quotedAt,fetchedAt,validUntil};
test('theme retains native effective price and exposes only the dedicated Mova feed',async()=>{
 const form=await readFile(new URL('../snipplets/product/product-form.tpl',import.meta.url),'utf8');
 assert.match(form,/component\('payment-discount-price'/);assert.match(form,/product-currency\.tpl/);
 assert.match(snippet,/custom_product_currency_quote/);assert.doesNotMatch(adapter,/fetch\(|XMLHttpRequest|LS\.currency|\.submit\(|addToCart|maxPaymentDiscount/);
 assert.match(adapter,/data-priceraw-without-shipping/);
});
test('currency UI, native price updates, invalid quote and expiry remain isolated at desktop/mobile',async t=>{
 const browser=await chromium.launch({channel:'chrome'});t.after(()=>browser.close());
 // Use the actual feature rules, not an alternate implementation of its styles.
 const rules=[...scss.matchAll(/^\s*(\.product-currency[^\n]+\{[^\n]+\})/gm)].map(m=>m[1]);
 const css=rules.slice(0,9).map(r=>'.single-product-page '+r).join('\n')+
   '\n@media(min-width:768px){'+rules.slice(9).map(r=>'.single-product-page '+r).join('\n')+'}';
 for(const width of [1920,440])await t.test(String(width),async()=>{
  const page=await browser.newPage({viewport:{width,height:900}});
  try{
   await page.setContent(`<style>*{box-sizing:border-box}.product-cash-discount{display:flex;height:50px}.product-cash-discount-details{position:relative;width:282px}.product-cash-price{display:block;font:600 18px/18px sans-serif}${css}</style><main class="single-product-page"><div class="product-cash-discount"><div class="product-cash-discount-details"><div class="product-cash-discount-price"><span class="js-payment-discount-price-product product-cash-price" data-priceraw-without-shipping="131841000">$1.318.410,00</span><span>con Efectivo</span></div>${snippet.replace('{{ product.id }}','45').replace('{{ store.currency }}','ARS').replace(/\{\{ component[^\n]+\}\}/,'<div data-nubesdk-slot="custom_product_currency_quote"></div>').replace(/\{\{[^}]+\}\}/g,'Moneda informativa')}</div></div><div id="long-description">Native long description</div><input name="quantity" value="2"><button id="cart">Native cart</button></main>`);
   await page.addScriptTag({content:adapter});
   const toggle=page.locator('[data-product-currency-toggle]'),usd=page.locator('[data-product-currency-usd]');
   assert.equal(await toggle.isVisible(),false);
   const send=async(payload)=>page.locator('[data-nubesdk-slot]').evaluate((el,data)=>{el.textContent=JSON.stringify(data);},payload);
   await send({version:1,productId:'45',quote,remainingMs:60000});await toggle.waitFor({state:'visible'});
   const geometry=await toggle.evaluate(e=>({height:e.getBoundingClientRect().height,width:e.getBoundingClientRect().width,font:getComputedStyle(e.querySelector('button')).fontSize}));
   assert.equal(geometry.height,width===440?11:15);assert.equal(geometry.width,width===440?46:55.59375);assert.equal(geometry.font,width===440?'7px':'9px');
   await toggle.locator('[data-product-currency="USD"]').click();assert.equal(await usd.innerText(),'US$ 884,84');
   const native=page.locator('.js-payment-discount-price-product');assert.equal(await native.textContent(),'$1.318.410,00');
   // Native variant price setter: no adapter discount arithmetic.
   await native.evaluate(el=>{el.setAttribute('data-priceraw-without-shipping','14900000');el.textContent='$149.000,00';});
   await page.waitForFunction(()=>document.querySelector('[data-product-currency-usd]').textContent==='US$ 100,00');
   await native.evaluate(el=>{el.textContent='$298.000,00';});await toggle.waitFor({state:'hidden'});
   await native.evaluate(el=>el.setAttribute('data-priceraw-without-shipping','29800000'));await toggle.waitFor({state:'visible'});
   await toggle.locator('[data-product-currency="USD"]').click();assert.equal(await usd.innerText(),'US$ 200,00');
   await page.evaluate(()=>window.initializeProductCurrency(document.querySelector('main')));
   await toggle.waitFor({state:'visible'});await toggle.locator('[data-product-currency="USD"]').click();assert.equal(await usd.innerText(),'US$ 200,00');
   for(const payload of [{version:1,productId:'wrong',quote,remainingMs:60000},{version:1,productId:'45',quote:{...quote,side:'venta'},remainingMs:60000},{version:1,productId:'45',quote:{...quote,arsPerUsd:0},remainingMs:60000},{version:1,productId:'45',quote,remainingMs:0}]){await send(payload);await toggle.waitFor({state:'hidden'});assert.equal(await native.evaluate(e=>getComputedStyle(e).visibility),'visible');}
   await send({version:1,productId:'45',quote,remainingMs:50});await toggle.waitFor({state:'visible'});await toggle.waitFor({state:'hidden'});
   assert.equal(await page.locator('#long-description').innerText(),'Native long description');assert.equal(await page.locator('[name="quantity"]').inputValue(),'2');assert.equal(await page.locator('#cart').isEnabled(),true);
  }finally{await page.close();}
 });
});
