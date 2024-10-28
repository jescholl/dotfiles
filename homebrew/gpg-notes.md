After installing gnupg and pinentry-mac, run the following

echo pinentry-program /opt/homebrew/bin/pinentry-mac > ~/.gnupg/gpg-agent.conf

gpgconf --kill gpg-agent
