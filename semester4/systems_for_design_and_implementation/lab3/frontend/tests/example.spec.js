const { test, expect } = require('@playwright/test');

test('should edit a dream', async ({ page }) => 
{
  await page.goto('http://localhost:3000/edit');
  await page.fill('[data-testid=title]', 'Edited Dream Title');
  await page.fill('[data-testid=description]', 'Edited Dream Description');
  await page.fill('[data-testid=lucidity]', '0.9');
  await page.click('[type=submit]');
  await page.waitForURL('http://localhost:3000/edit');
});

test('should add a new dream', async ({ page }) => 
{
  await page.goto('http://localhost:3000/add');
  await page.fill('[data-testid=title]', 'New Dream Title');
  await page.fill('[data-testid=description]', 'New Dream Description');
  await page.fill('[data-testid=lucidity]', '0.9');
  await page.click('[type=submit]');
  await page.waitForURL('http://localhost:3000/');
});

test('should delete a dream', async ({ page }) => 
{
  await page.goto('http://localhost:3000/');
  await page.click('[data-testid=delete]');
  await page.waitForURL('http://localhost:3000/');
});

test('sorting works', async ({ page }) => {
  await page.goto('http://localhost:3000/');
  await page.click('[data-testid=sort]');
  
  const sortedDreams = await page.$$('[data-testid=dream]');

  const dreamLucidityValues = await Promise.all(sortedDreams.map(async (dreamElement) => {
    const lucidityText = await dreamElement.innerText('[data-testid=lucidity]');
    return parseFloat(lucidityText);
  }));

  const isDescendingOrder = dreamLucidityValues.every((value, index, array) => {
    if (index === 0) {
      return true; // the first element will always be in descending order
    }
    return value <= array[index - 1]; // checking if the current value is less than or equal to the previous value
  });

  expect(isDescendingOrder).toBe(true);
});

test('should display 15 dreams', async ({ page }) =>
{
  await page.goto('http://localhost:3000/');
  await page.selectOption('select', '15');
  const dreams = await page.$$('[data-testid=delete]');
  expect(dreams.length).toBe(15);
});

test('barchart component displays modal and chart', async ({ page }) => {
  await page.goto('http://localhost:3000');

  await page.click('[data-testid=chart]');

  // Wait for the modal to appear
  await page.waitForSelector('.modal'); // Adjust the selector to match your modal's class or attributes

  // Assert that the modal is displayed
  const isModalVisible = await page.isVisible('.modal'); // Check if the modal is visible
  expect(isModalVisible).toBeTruthy();
});
