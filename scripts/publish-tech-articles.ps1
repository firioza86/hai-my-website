$ErrorActionPreference = 'Stop'

$sourceRoot = 'C:\Users\firio\Desktop\Website2026\RojakTech\public'
$targetRoot = 'C:\Users\firio\Desktop\Website2026\HaiMy\dist'

$articles = @(
    @{ File='disney-plus-malaysia-pengalaman-baharu.html'; Category='Digital'; Title='Disney+ Malaysia Akan Berubah 7 Oktober — Senarai dan Sejarah Tontonan Anda Tidak Dibawa'; Image='https://media.rojaktech.com/news-disney-plus-malaysia-baru.png'; Time='3 min' },
    @{ File='dario-amodei-perlahan-ai-frontier.html'; Category='AI'; Title='Bos Anthropic Mahu Perlumbaan AI Diperlahankan — Mengapa Amaran Ini Serius?'; Image='https://media.rojaktech.com/news-ai-perlahankan-frontier.png'; Time='4 min' },
    @{ File='netflix-malaysia-kenaikan-harga-2026.html'; Category='Digital'; Title='Netflix Malaysia Naik Harga Lagi — Berapa Banyak Anda Perlu Bayar Sekarang?'; Image='https://media.rojaktech.com/news-netflix-malaysia-harga-baru.png'; Time='4 min' },
    @{ File='chatgpt-pro-pendaftaran-baharu-dijeda.html'; Category='AI'; Title='Pelan ChatGPT Pro AS$200 Dijeda untuk Pengguna Baharu Ketika Astra Dilancar'; Image='https://media.rojaktech.com/news-chatgpt-pro-pendaftaran-pause.png'; Time='3 min' },
    @{ File='gemini-aplikasi-desktop-windows.html'; Category='Aplikasi'; Title='Gemini Kini Ada Aplikasi Windows — Akses AI Hanya Dengan Alt + Space'; Image='https://media.rojaktech.com/news-gemini-windows.png'; Time='4 min' },
    @{ File='ai-malaysia-lembaga-pengarah-pertama.html'; Category='AI'; Title='AI Malaysia Kini Ada Lembaga Pengarah — Siapa Yang Akan Memandu Agenda Negara?'; Image='https://media.rojaktech.com/news-ai-malaysia-lembaga.png'; Time='4 min' },
    @{ File='byd-batal-tanjong-malim-ckd-malaysia.html'; Category='Gajet'; Title='BYD Batalkan Kilang Tanjong Malim — Adakah Pelan CKD Malaysia Masih Hidup?'; Image='https://media.rojaktech.com/news-byd-tanjong-malim-ckd.png'; Time='4 min' },
    @{ File='insta360-luna-pro-malaysia.html'; Category='Gajet'; Title='Insta360 Luna Pro Tiba di Malaysia: Kamera Gimbal 8K Bermula RM2,099'; Image='https://media.rojaktech.com/news-insta360-luna-pro-malaysia.png'; Time='4 min' },
    @{ File='iphone-handoff-satu-esim-dua-iphone.html'; Category='Gajet'; Title='Satu eSIM untuk Dua iPhone? Ciri Handoff Ini Masih Ada Caj Bulanan'; Image='https://media.rojaktech.com/news-iphone-handoff-esim.png'; Time='3 min' },
    @{ File='youtube-tv-kunci-profil-pin.html'; Category='Aplikasi'; Title='YouTube di TV Kini Boleh Dikunci Dengan PIN — Cara Mengaktifkannya'; Image='https://media.rojaktech.com/news-youtube-tv-pin.png'; Time='3 min' }
)

$articleCss = Get-Content -Raw -LiteralPath (Join-Path $sourceRoot 'pages.css')
$articleCss += @'

/* HAI.my technology desk */
:root{--hai:#292172;--lime:#dfff45}body{font-family:Arial,Helvetica,sans-serif}.top{background:var(--hai)!important;color:#fff!important}.logo{width:148px!important;height:auto!important}.tag,.related-kicker{color:var(--hai)!important}.back{background:var(--lime)!important;color:#111!important;border-color:#111!important}.article h1{letter-spacing:-.04em}.source-note{border-left-color:var(--hai)!important}.related-card em{color:var(--hai)!important}@media(max-width:760px){.nav nav{display:none}.logo{width:120px!important}}
'@
Set-Content -LiteralPath (Join-Path $targetRoot 'tech-article.css') -Value $articleCss -Encoding utf8

foreach ($item in $articles) {
    $source = Join-Path $sourceRoot $item.File
    $html = Get-Content -Raw -LiteralPath $source
    $html = $html.Replace('RojakTech', 'HAI.my').Replace('ROJAKTECH', 'HAI.MY')
    $html = $html.Replace('https://rojaktech.com/', 'https://hai.my/')
    $html = $html.Replace('https://media.rojaktech.com/logo-rojaktech.png', 'logo-hai.png')
    $html = $html.Replace('href="pages.css"', 'href="tech-article.css"')
    $html = $html.Replace('href="kategori.html?cat=AI"', 'href="index.html#terkini"')
    $html = $html.Replace('href="kategori.html?cat=Gajet"', 'href="index.html#terkini"')
    $html = $html.Replace('href="kategori.html?cat=Aplikasi"', 'href="index.html#terkini"')
    $html = $html.Replace('href="kategori.html?cat=Digital"', 'href="index.html#terkini"')
    $html = $html.Replace('href="video.html"', 'href="index.html#terkini"')
    $html = $html.Replace('YouTube di TV Kini Boleh Dikunci Dengan PIN — Ibu Bapa Patut Aktifkan Ini', 'YouTube di TV Kini Boleh Dikunci Dengan PIN — Cara Mengaktifkannya')
    $html = $html.Replace('Pelajar, penulis, penganalisis dan pengguna', 'Pereka, penulis, penganalisis dan pengguna')
    $html = [regex]::Replace($html, '<a class="related-card" href="(?:byd-atto-3-performance-malaysia|oppo-a7-pro-max-rekaan-lasak)\.html".*?</a>', '', [System.Text.RegularExpressions.RegexOptions]::Singleline)
    Set-Content -LiteralPath (Join-Path $targetRoot $item.File) -Value $html -Encoding utf8
}

@('apps-group-assignment.html', 'ai-tools-assignment.html', 'thumb-students.png', 'thumb-ai-study.png') | ForEach-Object {
    $obsolete = Join-Path $targetRoot $_
    if (Test-Path -LiteralPath $obsolete) { Remove-Item -LiteralPath $obsolete }
}

$legacyLinks = @{
    'telefon-cukup-jadi-creator.html' = @{ 'ai-tools-assignment.html' = 'dario-amodei-perlahan-ai-frontier.html' }
    'setup-gaming-bajet.html' = @{ 'ai-tools-assignment.html' = 'dario-amodei-perlahan-ai-frontier.html'; 'apps-group-assignment.html' = 'gemini-aplikasi-desktop-windows.html' }
    'reset-algoritma-feed.html' = @{ 'apps-group-assignment.html' = 'gemini-aplikasi-desktop-windows.html' }
}
foreach ($page in $legacyLinks.Keys) {
    $pagePath = Join-Path $targetRoot $page
    $pageHtml = Get-Content -Raw -LiteralPath $pagePath
    foreach ($oldLink in $legacyLinks[$page].Keys) { $pageHtml = $pageHtml.Replace($oldLink, $legacyLinks[$page][$oldLink]) }
    Set-Content -LiteralPath $pagePath -Value $pageHtml -Encoding utf8
}

$indexPath = Join-Path $targetRoot 'index.html'
$lines = Get-Content -LiteralPath $indexPath
$lines[0] = $lines[0].Replace('gaming, apps, creator tools, student life dan AI', 'AI, gajet, aplikasi, gaming dan trend digital')
$lines[3] = '</style></head><body><div class="topbar"><div class="wrap"><span><b>HAI!</b> Teknologi dalam bahasa kita</span><span>Malaysia · 2026</span></div></div><header><div class="wrap nav"><a href="#" aria-label="HAI.my halaman utama"><img class="logo" src="logo-hai.png" alt="HAI.my"></a><nav class="links" id="navLinks" aria-label="Navigasi utama"><a href="#terkini">Terkini</a><a href="#ai">AI</a><a href="#gajet">Gajet</a><a href="#aplikasi">Aplikasi</a><a href="#gaming">Gaming</a><a href="#digital">Digital</a></nav><a class="social" href="#newsletter">Join HAI! Club</a><button class="menu" id="menuButton" aria-label="Buka menu" aria-expanded="false">☰</button></div></header><main>'
$lines[4] = '<section class="hero"><div class="wrap hero-grid"><a class="hero-feature" href="disney-plus-malaysia-pengalaman-baharu.html"><img src="hero-youth.png" alt="Anak muda Malaysia mengikuti perkembangan teknologi"><div class="hero-copy"><span class="label">Teknologi &amp; Digital</span><h1>Teknologi bergerak pantas. HAI.my terangkan yang penting.</h1></div></a><div class="hero-side"><article class="trend"><div class="trend-top"><span>Sekarang trending</span><span>01</span></div><div><h2>Gemini kini ada aplikasi Windows dengan akses Alt + Space</h2><a href="gemini-aplikasi-desktop-windows.html">Baca artikel →</a></div></article><div class="quick-grid"><a class="quick" href="dario-amodei-perlahan-ai-frontier.html"><span>AI</span><h3>Mengapa ketua Anthropic mahu perlumbaan AI diperlahankan?</h3></a><a class="quick" href="insta360-luna-pro-malaysia.html"><span>Gajet</span><h3>Kamera gimbal 8K baharu tiba di Malaysia.</h3></a></div></div></div></section>'
$lines[5] = '<div class="marquee" aria-hidden="true"><div class="marquee-track"><span>Artificial Intelligence</span><span>Gajet</span><span>Aplikasi</span><span>Gaming &amp; Esports</span><span>Digital</span><span>Artificial Intelligence</span><span>Gajet</span><span>Aplikasi</span><span>Gaming &amp; Esports</span><span>Digital</span></div></div>'

$cards = foreach ($item in $articles) {
    $id = switch ($item.Category) { 'AI' {'ai'} 'Gajet' {'gajet'} 'Aplikasi' {'aplikasi'} default {'digital'} }
    '<a class="story" data-category="' + $item.Category + '" id="' + $id + '" href="' + $item.File + '"><div class="story-image" style="min-height:0;height:190px;margin-bottom:18px"><img src="' + $item.Image + '" alt="Thumbnail artikel ' + $item.Category + '" loading="lazy"></div><div class="story-meta"><span>' + $item.Category + '</span><span>' + $item.Time + '</span></div><h3>' + $item.Title + '</h3></a>'
}
$lines[6] = '<section class="section wrap" id="terkini"><div class="section-head"><h2>Artikel teknologi<br>terkini.</h2></div><div class="filters" aria-label="Tapis artikel"><button class="filter active" data-filter="Semua">Semua</button><button class="filter" data-filter="AI">AI</button><button class="filter" data-filter="Gajet">Gajet</button><button class="filter" data-filter="Aplikasi">Aplikasi</button><button class="filter" data-filter="Digital">Digital</button></div><div class="stories">' + ($cards -join '') + '</div></section>'

$reviewCards = $articles | Select-Object -First 4 | ForEach-Object {
    '<a class="tool" href="' + $_.File + '" style="grid-template-columns:92px 1fr 30px"><img src="' + $_.Image + '" alt="" style="width:92px;height:92px;object-fit:cover" loading="lazy"><div><span class="tool-num">' + $_.Category + '</span><br><b>' + $_.Title + '</b></div><span>↗</span></a>'
}
$lines[7] = '<section class="toolkit" id="tools"><div class="wrap"><div class="toolkit-head"><h2>Pilihan Editor</h2></div><div class="tool-list">' + ($reviewCards -join '') + '</div></div></section>'
$lines[8] = '<section class="section wrap manifesto"><h2>Teknologi laju.<br>Kita bagi<br>arah.</h2><div class="manifesto-right"><p>HAI.my membawakan berita dan panduan teknologi untuk pembaca Malaysia—daripada AI dan gajet kepada aplikasi, gaming serta kehidupan digital.</p><div class="pillars"><div class="pillar">Artificial Intelligence</div><div class="pillar">Gajet</div><div class="pillar">Aplikasi</div><div class="pillar">Gaming &amp; Esports</div><div class="pillar">Digital</div><div class="pillar">Bahasa kita</div></div></div></section><section class="newsletter" id="newsletter"><div class="wrap"><h2>Yang penting,<br>terus ke inbox.</h2><div><p>Ringkasan berita, aplikasi dan idea teknologi pilihan HAI.my. Pendek, padat, tidak mengganggu.</p><form class="form" id="signup"><input type="email" required aria-label="Alamat e-mel" placeholder="nama@email.com"><button type="submit">Langgan →</button></form></div></div></section></main><footer><div class="wrap footer"><div><img class="footer-logo" src="logo-hai.png" alt="HAI.my"><p>© 2026 HAI.my · Gaya Hidup Digital</p></div><div class="footer-links"><a href="#terkini">Artikel</a><a href="#tools">Pilihan Editor</a><a href="#">Tentang</a><a href="#">Instagram</a><a href="#">TikTok</a></div></div></footer><script>const m=document.querySelector("#menuButton"),n=document.querySelector("#navLinks");m.addEventListener("click",()=>{const o=n.classList.toggle("open");m.setAttribute("aria-expanded",o);m.textContent=o?"×":"☰"});n.querySelectorAll("a").forEach(a=>a.addEventListener("click",()=>{n.classList.remove("open");m.setAttribute("aria-expanded","false");m.textContent="☰"}));document.querySelectorAll(".filter").forEach(b=>b.addEventListener("click",()=>{document.querySelectorAll(".filter").forEach(x=>x.classList.remove("active"));b.classList.add("active");const p=b.dataset.filter;document.querySelectorAll(".story").forEach(s=>s.hidden=p!=="Semua"&&s.dataset.category!==p)}));document.querySelector("#signup").addEventListener("submit",e=>{e.preventDefault();const b=e.currentTarget.querySelector("button");b.textContent="Berjaya ✓";b.disabled=true})</script></body></html>'
Set-Content -LiteralPath $indexPath -Value $lines -Encoding utf8
