# Base
FROM debian
RUN apt-get update && apt-get install -y iceweasel && \
    apt-get install -y xz-utils gnupg && \
    apt-get autoremove && apt-get clean

# Add user
RUN find / -type f -perm /6000 -exec chmod -s {} + 2>/dev/null || true
RUN groupadd -g 1000 user && useradd -g user -m -u 1000 user

# Get TB files
COPY --chown=user:user tor-browser* /home/user/

# Change to user
USER user
ENV HOME /home/user

# Verify and install TBB
RUN gpg --import /home/user/tor-browser-bundle.pub
RUN gpg --verify /home/user/tor-browser.tar.xz.asc
RUN cd /home/user && tar xJf tor-browser.tar.xz
RUN cd /home/user && rm  tor-browser-bundle.pub tor-browser.tar.xz tor-browser.tar.xz.asc

# Disable startup prompt
RUN echo 'pref("extensions.torlauncher.prompt_at_startup", false);' >> /home/user/tor-browser_en-US/Browser/TorBrowser/Data/Browser/profile.default/preferences/extension-overrides.js && \
# Set high security as default
    echo 'pref("extensions.torbutton.security_slider", 1);' >> /home/user/tor-browser_en-US/Browser/TorBrowser/Data/Browser/profile.default/preferences/extension-overrides.js && \
    echo 'pref("extensions.torbutton.show_slider_notification", false);' >> /home/user/tor-browser_en-US/Browser/TorBrowser/Data/Browser/profile.default/preferences/extension-overrides.js && \
# XMonad tiling fix - potential fingerprinting vector
    echo 'pref("extensions.torbutton.resize_new_windows", 0);' >> /home/user/tor-browser_en-US/Browser/TorBrowser/Data/Browser/profile.default/preferences/extension-overrides.js && \
# Don't preload hovered links
    echo 'pref("network.http.speculative-parallel-limit", 0);' >> /home/user/tor-browser_en-US/Browser/TorBrowser/Data/Browser/profile.default/preferences/extension-overrides.js && \
# Change search engine to Startpage - DDG is pretty slow with no JS
    echo 'pref("browser.search.order.extra.1", "Startpage");' >> /home/user/tor-browser_en-US/Browser/TorBrowser/Data/Browser/profile.default/preferences/extension-overrides.js && \
    echo 'pref("browser.search.defaultenginename", "Startpage");' >> /home/user/tor-browser_en-US/Browser/TorBrowser/Data/Browser/profile.default/preferences/extension-overrides.js

# It's go time
CMD cd /home/user/tor-browser_en-US && ./start-tor-browser.desktop --verbose
