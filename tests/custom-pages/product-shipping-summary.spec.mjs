import { test, expect } from '@playwright/test';
import fs from 'node:fs';
import vm from 'node:vm';

const source = fs.readFileSync(new URL('../../static/js/store.js.tpl', import.meta.url), 'utf8');
const start = source.indexOf('function productShippingSummaryData(option)');
const end = source.indexOf('var productShipping =', start);
const readSummary = vm.runInNewContext(`(${source.slice(start, end).trim()})`);

function option({cost = '0', show = 'true', price = 'Gratis', date = 'Llega entre hoy y el lunes', method = 'Envío Flex'} = {}) {
  const values = { '[data-component="option.price"] p': price, '[data-component="option.date"]': date, '[data-component="option.name"]': method };
  return { dataset: { shippingCost: cost, shippingShowPrice: show }, querySelector: selector => values[selector] === null ? null : { textContent: values[selector] } };
}

test('envío: precio cero confirmado se presenta gratis', () => {
  expect(readSummary(option()).free).toBe(true);
});
test('envío: conserva costo y fecha reales de una opción paga', () => {
  const data = readSummary(option({cost: '2500', price: '$ 2.500,00', date: 'Llega el viernes'}));
  expect(data.free).toBe(false);
  expect(data.price).toBe('$ 2.500,00');
  expect(data.date).toBe('Llega el viernes');
});
test('envío: sin precio visible no afirma envío gratis', () => {
  expect(readSummary(option({show: 'false', price: null})).free).toBe(false);
});
test('envío: no inventa fecha ni cuenta regresiva cuando faltan', () => {
  const data = readSummary(option({date: null}));
  expect(data.date).toBe('');
  expect(data.method).toBe('Envío Flex');
});
test('envío: normaliza espacios del texto nativo sin cambiar su contenido', () => {
  expect(readSummary(option({date: '  Llega entre hoy\n y el lunes 05/10  '})).date).toBe('Llega entre hoy y el lunes 05/10');
});
test('envío: mantiene el cálculo nativo y limita el resumen a Product Page', () => {
  expect(source).toContain("document.querySelector('.single-product-page #product-shipping-container')");
  expect(source).toContain('LS.calculateShippingAjax(');
  expect(source).not.toContain('Llega HOY');
  const markup = fs.readFileSync(new URL('../../snipplets/shipping/shipping-calculator.tpl', import.meta.url), 'utf8');
  expect(markup).toContain('aria-controls="product-shipping-details"');
  expect(markup).toContain('js-shipping-calculator-change-zipcode');
});
