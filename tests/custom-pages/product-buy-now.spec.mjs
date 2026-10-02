import { test, expect } from '@playwright/test';
import fs from 'node:fs';
import vm from 'node:vm';

const source = fs.readFileSync(new URL('../../static/js/store.js.tpl', import.meta.url), 'utf8');
const start = source.indexOf('buyNowConfirmationListener = function(event) {');
const end = source.indexOf('document.addEventListener(LS.events.productAddedToCart, buyNowConfirmationListener);', start);
const confirmationSource = source.slice(start + 'buyNowConfirmationListener = '.length, end).trim().replace(/;$/, '');

function setup({ updated = true, quantity = 2, itemExists = true, checkoutExists = true, checkoutDisabled = false, checkoutHidden = false, valid = true } = {}) {
  const calls = { checkout: 0, restored: 0, modal: 0, removed: 0 };
  const checkoutButton = { disabled: checkoutDisabled, closest: () => ({ style: { display: checkoutHidden ? 'none' : '' } }) };
  const checkoutForm = { querySelector: () => checkoutButton, checkValidity: () => valid, requestSubmit: button => {
    expect(button).toBe(checkoutButton);
    calls.checkout++;
  } };
  const context = {
    buyNowCartUpdated: updated,
    productForm: { dataset: { buyNowPending: 'true' } },
    requestedProduct: 123,
    requestedQuantity: quantity,
    LS: { events: { productAddedToCart: 'productAddedToCart' } },
    document: {
      querySelector: selector => selector.startsWith('form.') ? (checkoutExists ? checkoutForm : null)
        : itemExists && selector === '.js-cart-item[data-item-id="7"][data-store="cart-item-123"]' ? {} : null,
      removeEventListener: () => calls.removed++,
    },
    restore_button_initial_state: () => { calls.restored++; delete context.productForm.dataset.buyNowPending; },
    modalOpen: () => calls.modal++,
  };
  const confirm = vm.runInNewContext(`(${confirmationSource})`, context);
  context.buyNowConfirmationListener = confirm;
  const event = { detail: { cart_item: { id: 7 }, quantity_added: quantity } };
  return { calls, context, confirm, event };
}

test('comprar ahora: no avanza por un evento sin callback nativo confirmado', () => {
  const s = setup({ updated: false });
  s.confirm(s.event);
  expect(s.calls.checkout).toBe(0);
  expect(s.calls.restored).toBe(0);
});

test('comprar ahora: sólo envía el formulario nativo después del alta completa', () => {
  const s = setup({ quantity: 3 });
  expect(s.calls.checkout).toBe(0);
  s.confirm(s.event);
  expect(s.calls.checkout).toBe(1);
  expect(s.calls.removed).toBe(1);
  expect(s.calls.restored).toBe(0);
});

test('comprar ahora: un alta parcial por stock no inicia checkout', () => {
  const s = setup({ quantity: 3 });
  s.event.detail.quantity_added = 1;
  s.confirm(s.event);
  expect(s.calls.checkout).toBe(0);
  expect(s.calls.restored).toBe(1);
});

test('comprar ahora: un ítem ajeno o ausente no confirma la compra', () => {
  const s = setup({ itemExists: false });
  s.confirm(s.event);
  expect(s.calls.checkout).toBe(0);
  expect(s.calls.restored).toBe(1);
});

for (const [name, configuration] of Object.entries({
  'formulario ausente': { checkoutExists: false },
  'checkout deshabilitado': { checkoutDisabled: true },
  'validación comercial': { checkoutHidden: true },
  'formulario inválido': { valid: false },
})) {
  test(`comprar ahora: respeta ${name} y abre el carrito nativo`, () => {
    const s = setup(configuration);
    s.confirm(s.event);
    expect(s.calls.checkout).toBe(0);
    expect(s.calls.restored).toBe(1);
    expect(s.calls.modal).toBe(1);
  });
}

test('comprar ahora: una confirmación tardía tras error no navega', () => {
  const s = setup();
  delete s.context.productForm.dataset.buyNowPending;
  s.confirm(s.event);
  expect(s.calls.checkout).toBe(0);
});

test('comprar ahora: conserva el CTA original y no duplica addToCartEnhanced', () => {
  const form = fs.readFileSync(new URL('../../snipplets/product/product-form.tpl', import.meta.url), 'utf8');
  expect(form).toContain('class="js-addtocart js-prod-submit-form btn-add-to-cart');
  expect(form).toContain('type="button" class="js-product-buy-now');
  expect(source.match(/LS\.addToCartEnhanced\(/g)).toHaveLength(1);
  expect(source).toContain('!productForm.reportValidity()');
});
