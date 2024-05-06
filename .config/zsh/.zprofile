eval "$(/opt/homebrew/bin/brew shellenv)"


# ruby
PATH="/opt/homebrew/ruby/bin:$PATH"
GEMSDIR=$(gem environment gemdir)/bin
PATH=$GEMSDIR:$PATH
