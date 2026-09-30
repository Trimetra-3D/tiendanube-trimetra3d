import { readFile } from "node:fs/promises";
import { expect, test } from "@playwright/test";

const rootUrl = new URL("../../", import.meta.url);
const criticalCss = await readFile(new URL("static/css/style-critical.scss", rootUrl), "utf8");
const promoConfig = await readFile(new URL("snipplets/payment-installments-config.tpl", rootUrl), "utf8");
const promoHeader = await readFile(new URL("snipplets/header/header-advertising.tpl", rootUrl), "utf8");
const promoEligibility = await readFile(new URL("snipplets/payment-promo-product-eligibility.tpl", rootUrl), "utf8");
const productInstallments = await readFile(new URL("snipplets/product/product-installments-summary.tpl", rootUrl), "utf8");
const storeJs = await readFile(new URL("static/js/store.js.tpl", rootUrl), "utf8");

const countdownMarkup = `
  <header class="head-main">
    <a href="https://www.trimetra3d.com.ar/snapmaker-bambulab" class="js-adbar section-adbar section-adbar--countdown" data-adbar-countdown>
      <div class="adbar-countdown">
        <span class="adbar-countdown__message" data-adbar-countdown-message>SE VIENE TREMENDA PROMO</span>
        <span class="adbar-countdown__label" data-adbar-countdown-label></span>
        <span class="adbar-countdown__timer" aria-hidden="true">
          <span class="adbar-countdown__unit adbar-countdown__unit--days"><strong>01</strong><small>DÍAS</small></span>
          <span class="adbar-countdown__unit"><strong>23</strong><small>HORAS</small></span>
          <span class="adbar-countdown__separator">:</span>
          <span class="adbar-countdown__unit"><strong>59</strong><small>MINUTOS</small></span>
          <span class="adbar-countdown__separator">:</span>
          <span class="adbar-countdown__unit"><strong>59</strong><small>SEGUNDOS</small></span>
        </span>
      </div>
    </a>
  </header>`;

async function renderCountdown(page, active = false) {
  await page.setContent(countdownMarkup);
  await page.addStyleTag({ content: criticalCss });
  await page.addStyleTag({ content: "html, body { margin: 0; } .section-adbar { display: flex; width: 100%; }" });

  if (active) {
    await page.evaluate(() => {
      const section = document.querySelector("[data-adbar-countdown]");
      section.classList.add("section-adbar--countdown-active");
      section.querySelector("[data-adbar-countdown-message]").textContent = "APROVECHA LAS 9 CUOTAS,";
      section.querySelector("[data-adbar-countdown-label]").textContent = "solo quedan...";
    });
  }
}

test("contrato de campaña Bambu Lab y Snapmaker", () => {
  expect(promoConfig).toContain("payment_promo_start_date = '2026-09-25'");
  expect(promoConfig).toContain("payment_promo_end_date = '2026-10-05'");
  expect(promoConfig).toContain("payment_promo_start_date ~ 'T09:57:00-03:00'");
  expect(promoConfig).toContain("payment_promo_end_date ~ 'T10:00:00-03:00'");
  expect(promoConfig).toContain("payment_promo_countdown = 'true'");
  expect(promoConfig).toContain("payment_promo_installments = '9'");
  expect(promoConfig).toContain("payment_promo_start_time_display = '09:57'");
  expect(promoConfig).toContain("payment_promo_end_time_display = '10:00'");
  expect(promoConfig).toContain("payment_promo_label = 'Bambu Lab y Snapmaker'");
  expect(promoConfig).toContain("payment_promo_scope = 'impresoras Bambu Lab y Snapmaker'");

  expect(promoHeader).toContain('data-adbar-countdown-before-message="SE VIENE TREMENDA PROMO"');
  expect(promoHeader).toContain('data-adbar-countdown-active-message="APROVECHA LAS 9 CUOTAS,"');
  expect(promoHeader).toContain('data-adbar-countdown-active-label="solo quedan..."');
  expect(promoHeader).toContain('mode: "promo_countdown"');
  expect(promoHeader).toContain('mode: "promo_scope"');
  expect(promoHeader).toContain('en {{ promo_adbar_countdown_scope }}');

  expect(promoEligibility).toContain("product.brand");
  expect(promoEligibility).toContain("not payment_promo_product_has_brand");
  expect(promoEligibility).toContain("'snapmaker' in payment_promo_product_brand");
  expect(promoEligibility).toContain("'snapmaker' in payment_promo_product_text");
  expect(promoEligibility).not.toContain("'impresora'");
  for (const accessory of ["filamento", "accesorio", "repuesto", "boquilla", "hotend", "extrusor", "placa", "cama", "ptfe"]) {
    expect(promoEligibility).toContain(`'${accessory}'`);
  }

  expect(productInstallments).toContain('data-max-installments="{{ product_installments_limit }}"');
  expect(productInstallments).toContain('data-promo-eligible="{{ product_promo_applies ? \'true\' : \'false\' }}"');
  expect(storeJs).toContain("$installments_summary.attr('data-max-installments')");
  expect(storeJs).toContain("get_max_installments_without_interests(number_of_installment, installment_data, max_installments_without_interests, max_installments_without_interests_to_show)");
});

test("límites temporales con el countdown real de la promo", async ({ page }) => {
  const configValue = (name) => promoConfig.match(new RegExp(`${name} = '([^']+)'`))[1];
  const startDate = configValue("payment_promo_start_date") + promoConfig.match(/payment_promo_start_date ~ '([^']+)'/)[1];
  const endDate = configValue("payment_promo_end_date") + promoConfig.match(/payment_promo_end_date ~ '([^']+)'/)[1];
  const start = new Date(startDate).getTime();
  const end = new Date(endDate).getTime();
  const markup = promoHeader.match(/<a\s[\s\S]*?<\/a>/)[0]
    .replace("{{ promo_adbar_countdown_start }}", startDate)
    .replace("{{ promo_adbar_countdown_end }}", endDate)
    .replace("{{ promo_adbar_countdown_scope }}", configValue("payment_promo_scope"));
  const countdownScript = storeJs.slice(
    storeJs.indexOf("function initAdbarCountdown()"),
    storeJs.indexOf("        initAdbarCountdown();")
  );

  await page.setContent(markup);
  await page.clock.install({ time: new Date(start - 1000) });
  await page.clock.pauseAt(new Date(start - 1000));
  await page.addScriptTag({ content: countdownScript + "\ninitAdbarCountdown();" });

  const bar = page.locator("[data-adbar-countdown]");
  const message = page.locator("[data-adbar-countdown-message]");
  for (const [timestamp, state] of [
    [start - 1000, "scheduled"],
    [start, "active"],
    [start + 1000, "active"],
    [end - 1000, "active"],
    [end, "active"],
    [end + 1000, "ended"]
  ]) {
    await page.clock.fastForward(timestamp - await page.evaluate(() => Date.now()));
    if (state === "ended") {
      await expect(bar).toBeHidden();
    } else {
      await expect(bar).toBeVisible();
      await expect(message).toHaveText(state === "active" ? "APROVECHA LAS 9 CUOTAS," : "SE VIENE TREMENDA PROMO");
      await expect(bar).toHaveClass(state === "active" ? /section-adbar--countdown-active/ : /section-adbar--countdown$/);
    }
  }
});

for (const viewport of [
  { name: "mobile 320", width: 320, height: 640 },
  { name: "mobile 390", width: 390, height: 844 },
  { name: "mobile horizontal", width: 667, height: 375 },
  { name: "tablet", width: 768, height: 900 },
  { name: "desktop", width: 1440, height: 900 }
]) {
  test(`countdown responsive: ${viewport.name}`, async ({ page }, testInfo) => {
    await page.setViewportSize({ width: viewport.width, height: viewport.height });
    await renderCountdown(page, true);

    const section = page.locator("[data-adbar-countdown]");
    const message = page.locator("[data-adbar-countdown-message]");
    const label = page.locator("[data-adbar-countdown-label]");
    const timer = page.locator(".adbar-countdown__timer");

    await expect(message).toHaveText("APROVECHA LAS 9 CUOTAS,");
    await expect(label).toHaveText("solo quedan...");
    await expect(page.locator(".adbar-countdown__unit")).toHaveCount(4);
    for (const unit of await page.locator(".adbar-countdown__unit").all()) {
      await expect(unit).toBeVisible();
    }
    for (const separator of await page.locator(".adbar-countdown__separator").all()) {
      await expect(separator).toBeVisible();
    }

    const sectionBox = await section.boundingBox();
    const messageBox = await message.boundingBox();
    const timerBox = await timer.boundingBox();
    expect(sectionBox).not.toBeNull();
    expect(messageBox).not.toBeNull();
    expect(timerBox).not.toBeNull();

    if (viewport.width < 768) {
      expect(sectionBox.height).toBeGreaterThanOrEqual(76);
      expect(timerBox.y).toBeGreaterThan(messageBox.y);
    } else {
      expect(sectionBox.height).toBe(50);
      expect(Math.abs(timerBox.y - messageBox.y)).toBeLessThan(12);
    }

    expect(await page.evaluate(() => document.documentElement.scrollWidth <= document.documentElement.clientWidth + 1)).toBe(true);

    if (process.env.PROMO_SCREENSHOTS === "1") {
      await page.screenshot({ path: testInfo.outputPath(`promo-${viewport.width}x${viewport.height}.png`), fullPage: true });
    }
  });
}

test("countdown respeta movimiento reducido", async ({ page }) => {
  await page.emulateMedia({ reducedMotion: "reduce" });
  await renderCountdown(page, true);
  const animationName = await page.locator("[data-adbar-countdown]").evaluate((node) => getComputedStyle(node).animationName);
  expect(animationName).toBe("none");
});
