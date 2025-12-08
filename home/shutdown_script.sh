# Update passwords in pass
pass git push

# Update dotfiles
cd ~/.homesick/repos/dotfiles
# We assume that we are always authorised as TheMossConcept
gh auth switch --user Nnoerregaard
git add -A
git commit -m "Dotfiles updated on shutdown"
git push
gh auth switch --user TheMossConcept

shutdown
