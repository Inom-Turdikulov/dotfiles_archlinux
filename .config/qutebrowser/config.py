# Aliases for commands. The keys of the given dictionary are the
# aliases, while the values are the commands they map to.
c.aliases = {
    "w": "session-save",
    "wq": "quit --save",
    "mpv": "spawn -d mpv --force-window=immediate {url}",
    "pass": "spawn -d pass -c",
}

# Always restore open sites when qutebrowser is reopened.
c.auto_save.session = True

# Whether quitting the application requires a confirmation.
# Valid values:
#   - always: Always show a confirmation.
#   - multiple-tabs: Show a confirmation if multiple tabs are opened.
#   - downloads: Show a confirmation if downloads are running
#   - never: Never show a confirmation.
c.confirm_quit = ["downloads"]

# Value to send in the `Accept-Language` header.
c.content.headers.accept_language = "ru_RU,ru;q=0.8,en_US;q=0.6,en;q=0.4"

# The editor (and arguments) to use for the `open-editor` command. `{}`
# gets replaced by the filename of the file to be edited.
c.editor.command = ["e '{}'"]

# Chars used for hint strings.
c.hints.chars = "rfvtgbyhnujm"

# The page to open if :open -t/-b/-w is used without URL. Use
# `about:blank` for a blank page.
c.url.default_page = "about:blank"

# Add flags (need test, not sure if it works)
c.qt.args = ['enable-features=VaapiVideoDecoder', 'disable-features=UseChromeOSDirectVideoDecoder']
