import random
import operator, re, typing
from urllib.parse import urljoin

from qutebrowser.api import interceptor, message
from PyQt5.QtCore import QUrl


def _debian_redir(url: QUrl) -> bool:
	p = url.path().strip('/')
	if p.isdigit():
		url.setPath(urljoin("/plain/", p))
		return True
	return False

def _the_compiler_redir(url: QUrl) -> bool:
	p = url.path().strip('/')
	res = re.search(r"\w+$", p)
	if p.startswith('view/') and res:
		url.setPath(urljoin("/view/raw/", res.group()))
		return True
	return False

def _pastebin_redir(url: QUrl) -> bool:
	p = url.path().strip('/')
	if p.isalnum():
		url.setPath(urljoin("/raw/", p))
		return True
	return False

def _hastebin_redir(url: QUrl) -> bool:
	p = url.path().strip('/')
	if "raw" not in p:
		url.setPath(urljoin("/raw/", p))
		return True
	return False

def _invidious_instance() -> str:
    instances = [ 'invidio.us', 'invidious.snopyta.org', 'invidious.13ad.de', 'invidious.fdn.fr', 'watch.nettohikari.com' ]
    return random.choice(instances)

def _nitter_instance() -> str:
    instances = [ 'nitter.nixnet.services', 'nitter.net' ]
    return random.choice(instances)

def _bibliogram_instance() -> str:
    instances = [ 'bibliogram.snopyta.org' ]
    return random.choice(instances)


# Any return value other than a literal 'False' means we redirected
REDIRECT_MAP = {
	"reddit.com": operator.methodcaller('setHost', 'old.reddit.com'),
	"www.reddit.com": operator.methodcaller('setHost', 'old.reddit.com'),
	"twitter.com": operator.methodcaller('setHost', _nitter_instance()),
	"www.twitter.com": operator.methodcaller('setHost', _nitter_instance()),
	"mobile.twitter.com": operator.methodcaller('setHost', _nitter_instance()),
        "youtube.com": operator.methodcaller('setHost', _invidious_instance()),
        "www.youtube.com": operator.methodcaller('setHost', _invidious_instance()),
        "instagram.com": operator.methodcaller('setHost', _bibliogram_instance()),
        "www.instagram.com": operator.methodcaller('setHost', _bibliogram_instance()),

	# Pastebins
	"paste.debian.net": _debian_redir,
	"paste.the-compiler.org": _the_compiler_redir,
	# Causes an infinite loop if the paste does not exist...
	"pastebin.com": _pastebin_redir,
	"hasteb.in": _hastebin_redir,
	"hastebin.com": _hastebin_redir,
} # type: typing.Dict[str, typing.Callable[..., typing.Optional[bool]]]

def int_fn(info: interceptor.Request):
	"""Block the given request if necessary."""
	if (info.resource_type != interceptor.ResourceType.main_frame or
			info.request_url.scheme() in {"data", "blob"}):
		return
	url = info.request_url
	redir = REDIRECT_MAP.get(url.host())
	if redir is not None and redir(url) is not False:
		message.info("Redirecting to " + url.toString())
		info.redirect(url)


interceptor.register(int_fn)
