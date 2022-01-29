if status is-interactive
    # Commands to run in interactive sessions can go here
# https://fishshell.com/docs/current/tutorial.html
# set -x MyVariable SomeValue === export

end

function zx
  source ~/.config/fish/config.fish
end

function save
  set currentLocation echo $PWD
  cd ~/Documents/dotFiles/postInstallScripts/
  bash ./lnSet.sh
    if test (count $argv) -eq 0
        git commit
    else
        git commit -m "$argv"
    end
    git push
  cd $currentLocation
end

# function sync

# (cd ~/Documents/dotFiles/postInstallScripts/ &&
#   git pull &&
#   bash ./syncDootsLocal.sh)
# end

