### File and Directory Operations
setopt auto_param_slash  # Auto-append slash to directory names during tab completion
setopt mark_dirs  # Mark directory names with a trailing slash during listing
setopt list_types  # Indicate file types in directory listings
setopt auto_cd  # Auto-cd into a directory by typing its name

### Shell Interactivity
setopt auto_menu  # Auto-list choices on ambiguous tab completion
setopt auto_param_keys  # Enable key-based parameter name completion
setopt interactive_comments  # Allow comments in interactive shells
setopt always_last_prompt  # Ensure prompt is always the last line on terminal

### Globbing and Pattern Matching
setopt extended_glob  # Enable extended globbing features
setopt globdots  # Include filenames starting with a dot in wildcard matches
setopt list_packed  # Show globbed patterns as individual matches

### Miscellaneous
setopt magic_equal_subst  # Allow filename expansion after equals sign in parameters
setopt complete_in_word  # Allow tab completion in middle of word
setopt print_eight_bit  # Print 8th bit set characters as is, no metafication

### History
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt extended_history
setopt hist_no_store
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt share_history

### Completion
autoload -U compinit && compinit -C
autoload -U bashcompinit && bashcompinit
zstyle ':completion:*:default' menu select=2 # select by arrow keys
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' verbose yes
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history # set the completion strategy sequence
zstyle ':completion:*:options' description 'yes'

### Others
bindkey -v
