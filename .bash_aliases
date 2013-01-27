alias l='clear && pwd && ls -s1h --color'

# Teleportation.
alias gogit='cd ~/workspace/git'
alias gotetris='cd ~/workspace/git/tetris'

# Git.
alias gs='git status'
alias gb='git branch'
alias gac='git add -A && git commit -a -m'
alias gpod='git pull origin develop'
alias gpom='git pull origin master'
alias gph='git push heroku master'

# Rails.
alias rake='bundle exec rake'
 
# Django.
alias djrun='python manage.py runserver'
alias djsync='python manage.py syncdb'
alias djshell='python manage.py shell'

# TODO: venvwrapper
alias venv-activate='source venv/bin/activate'