eval "$(/opt/homebrew/bin/brew shellenv)"


# ruby
PATH="/opt/homebrew/opt/ruby/bin:$PATH"
GEMSDIR=$(gem environment gemdir)/bin
PATH=$GEMSDIR:$PATH

# llvm / clang, etc.
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
