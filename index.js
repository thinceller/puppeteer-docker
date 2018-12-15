const puppeteer = require('puppeteer');

(async () => {
  const browser = await puppeteer.launch({
    executablePath: '/usr/bin/chromium-browser',
    headless: true,
    defaultViewport: { height: 1080, width: 1920 },
    args: ['--disable-dev-shm-usage', '--lang=ja,en-US,en']
  });

  const page = await browser.newPage();

  const url = 'https://baseconnect.in/search/companies';
  await page.goto(url);
  console.log(await page.title());
  await page.pdf({ path: 'test.pdf' });
  await page.emulateMedia('screen');
  await page.screenshot({ path: 'test.png', format: 'A4' });

  await page.close();
  await browser.close();
})();
