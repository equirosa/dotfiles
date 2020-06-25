# imports
import theme.spill

# Bindings
config.bind(',m', 'spawn xdg-open {url}')
config.bind(',M', 'hint links spawn xdg-open {url}')
config.bind(',y', 'spawn watchlist {url}')
config.bind(',Y', 'hint links spawn watchlist {url}')
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

c.content.javascript.enabled = False

config.source('./redirectors.py')

# TODO Sort these
c.content.fullscreen.window = True # Limits 'fullscreen' to window dimensions
c.content.autoplay = False # Disables autplay of videos
c.editor.command = [ 'alacritty', '-e', 'nvim', '{file}' ]
c.url.open_base_url = True # Opens search engine when no search param is given
c.url.searchengines = {
        'DEFAULT': 'https://searx.neocities.org/?q={}',
        'a': 'https://wiki.archlinux.org/index.php?search={}'
        }

# Load automatic config
# config.load_autoconfig()
