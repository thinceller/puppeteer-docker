const puppeteer = require('puppeteer');

(async () => {
  const browser = await puppeteer.launch({
    executablePath: '/usr/bin/chromium-browser',
    headless: true,
    defaultViewport: { height: 1920, width: 1080 },
    args: ['--disable-dev-shm-usage']
  });

  const page = await browser.newPage();

  const url = 'https://baseconnect.in/search/companies';
  await page.goto(url);
  console.log(await page.title());
  await page.pdf({ path: 'test.pdf' });

  await page.close();
  await browser.close();
})();
