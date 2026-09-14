const fs = require('fs');
const path = require('path');
const root = path.resolve(__dirname, '..', 'dist');
const files = fs.readdirSync(root).filter((file) => file.endsWith('.html'));
const broken = [];
for (const file of files) {
  const html = fs.readFileSync(path.join(root, file), 'utf8');
  for (const match of html.matchAll(/(?:src|href)="([^"#]+)"/g)) {
    const target = match[1];
    if (!/^(https?:|mailto:|javascript:|data:)/.test(target) && !fs.existsSync(path.join(root, target))) {
      broken.push(`${file} -> ${target}`);
    }
  }
}
if (broken.length) {
  console.error(broken.join('\n'));
  process.exit(1);
}
console.log(`Validated ${files.length} HTML pages and their local assets.`);
