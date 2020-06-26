# imports
import theme.spill

# Bindings
config.bind(',M', 'spawn xdg-open {url}')
config.bind(',m', 'hint links spawn xdg-open {url}')
config.bind(',Y', 'spawn watchlist {url}')
config.bind(',y', 'hint links spawn watchlist {url}')
config.bind('ar', "open javascript:location.href='https://reader.miniflux.app/bookmarklet?uri='+encodeURIComponent(window.location.href)")
config.bind('aw', "open javascript:(function()%7Bvar%20url=location.href%7C%7Curl;var%20wllbg=window.open('https://wallabag.nixnet.xyz/bookmarklet?url='%20+%20encodeURIComponent(url),'_blank');%7D)();")
config.bind('zl', 'spawn --userscript qute-pass --mode gopass')
config.bind('zol', 'spawn --userscript qute-pass --mode gopass --otp-only')

# Security/Privacy
c.content.cookies.accept = 'no-3rdparty'
c.content.host_blocking.lists = [ 'https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn/hosts' ]

# Theme Stuff and Styling
theme.spill.paint(c,{
    'spacing':{
        'vertical':0,
        'horizontal':0
    }
})
c.content.user_stylesheets = [ 'css/personal.css' ]

config.source('./redirectors.py')

# TODO Sort these
c.content.fullscreen.window = True # Limits 'fullscreen' to window dimensions
c.content.autoplay = False # Disables autplay of videos
c.editor.command = [ 'alacritty', '-e', 'nvim', '{file}' ]
c.url.open_base_url = True # Opens search engine when no search param is given
c.url.searchengines = {
        'DEFAULT': 'https://searx.neocities.org/?q={}',
        'a': 'https://wiki.archlinux.org/index.php?search={}',
        'f': 'https://flathub.org/apps/search/{}'
        }

# Load automatic config
# config.load_autoconfig()

# JS
c.content.javascript.enabled = False
allow_JS  = [
    "*://localhost/*",
    "*://127.0.0.1/*",
    "https://github.com/*",
    "https://flathub.org/*",
    "https://searx.neocities.org/*",
    "https://web.whatsapp.com",
    "https://moodle.ucenfotec.ac.cr/*"
]
for site in allow_JS:
    with config.pattern(site) as p:
        p.content.javascript.enabled = True

c.spellcheck.languages = [ "en-US", "es-ES"]
